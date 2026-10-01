#!/usr/bin/env ruby

require "yaml"

ROOT = File.expand_path("..", __dir__)
DATA_DIR = File.join(ROOT, "_data")

def load_yaml(name)
  path = File.join(DATA_DIR, "#{name}.yml")
  raise "Missing #{path}" unless File.file?(path)

  YAML.load_file(path)
rescue Psych::SyntaxError => e
  raise "Invalid YAML in #{path}: #{e.message}"
end

def require_keys(record, keys, context)
  missing = keys.reject do |key|
    record.key?(key) && !record[key].nil? && record[key] != ""
  end
  raise "#{context} is missing: #{missing.join(', ')}" unless missing.empty?
end

def ensure_unique_ids(records, context)
  ids = {}
  records.each_with_index do |record, index|
    item_context = "#{context} item #{index + 1}"
    require_keys(record, %w[id], item_context)
    id = record["id"]
    raise "Duplicate #{context} id: #{id}" if ids[id]
    ids[id] = true
  end
  ids
end

def validate_link(value, context)
  return if value.nil? || value == ""
  return if value.start_with?("https://", "/")

  raise "#{context} must use https:// or an absolute site path"
end

profile = load_yaml("profile")
raise "profile.yml must contain a mapping" unless profile.is_a?(Hash)
require_keys(profile, %w[name title email_display google_scholar_id], "profile.yml")
if profile["photo"]
  raise "profile.yml photo file does not exist" unless File.file?(File.join(ROOT, profile["photo"].delete_prefix("/")))
  %w[photo_width photo_height].each do |key|
    raise "profile.yml #{key} must be a positive integer" unless profile[key].is_a?(Integer) && profile[key] > 0
  end
end

%w[favicon.ico assets/img/favicon-32x32.png assets/img/apple-touch-icon.png].each do |favicon|
  raise "Missing favicon asset: #{favicon}" unless File.file?(File.join(ROOT, favicon))
end

news = load_yaml("news")
raise "news.yml must contain a list" unless news.is_a?(Array)
news.each_with_index do |item, index|
  require_keys(item, %w[date text], "news.yml item #{index + 1}")
  validate_link(item["link"], "news.yml item #{index + 1} link")
end

publications = load_yaml("publications")
raise "publications.yml must contain a list" unless publications.is_a?(Array)
publication_ids = ensure_unique_ids(publications, "publications.yml")
titles = {}
publications.each_with_index do |publication, index|
  context = "publications.yml item #{index + 1}"
  require_keys(publication, %w[id title authors venue year selected], context)
  raise "#{context} year must be an integer" unless publication["year"].is_a?(Integer)
  raise "#{context} selected must be true or false" unless [true, false].include?(publication["selected"])
  title = publication["title"]
  raise "Duplicate publication title: #{title}" if titles[title]
  titles[title] = true

  links = publication["links"]
  raise "#{context} links must contain at least one link" unless links.is_a?(Hash) && links.values.any? { |value| value && value != "" }
  links.each { |label, value| validate_link(value, "#{context} link #{label}") }

  if publication["selected"] || publication["teaser"]
    require_keys(publication, %w[teaser teaser_alt teaser_source], context)
    teaser = publication["teaser"]
    raise "#{context} teaser must use an absolute site path" unless teaser.start_with?("/")
    raise "#{context} teaser file does not exist: #{teaser}" unless File.file?(File.join(ROOT, teaser.delete_prefix("/")))
    validate_link(publication["teaser_source"], "#{context} teaser source")
  end

  (publication["metrics"] || []).each do |metric|
    require_keys(metric, %w[label value observed_on url endpoint field], "#{context} metric")
    raise "#{context} metric value must be a non-negative integer" unless metric["value"].is_a?(Integer) && metric["value"] >= 0
    raise "#{context} metric date must be YYYY-MM-DD" unless metric["observed_on"].to_s.match?(/\A\d{4}-\d{2}-\d{2}\z/)
    %w[url endpoint].each { |key| validate_link(metric[key], "#{context} metric #{key}") }
  end
end

navigation = load_yaml("navigation")
raise "navigation.yml must contain a list" unless navigation.is_a?(Array)
nav_keys = {}
nav_urls = {}
navigation.each_with_index do |item, index|
  context = "navigation.yml item #{index + 1}"
  require_keys(item, %w[key label url], context)
  raise "Duplicate navigation key: #{item['key']}" if nav_keys[item["key"]]
  raise "Duplicate navigation URL: #{item['url']}" if nav_urls[item["url"]]
  nav_keys[item["key"]] = true
  nav_urls[item["url"]] = true
  validate_link(item["url"], "#{context} URL")
end

research = load_yaml("research")
raise "research.yml must contain a list" unless research.is_a?(Array)
ensure_unique_ids(research, "research.yml")
research.each_with_index do |direction, index|
  context = "research.yml item #{index + 1}"
  require_keys(direction, %w[id title summary publication_ids], context)
  direction["publication_ids"].each do |publication_id|
    raise "#{context} references unknown publication: #{publication_id}" unless publication_ids[publication_id]
  end
end

competitions = load_yaml("competitions")
raise "competitions.yml must contain a list" unless competitions.is_a?(Array)
ensure_unique_ids(competitions, "competitions.yml")
competitions.each_with_index do |competition, index|
  context = "competitions.yml item #{index + 1}"
  require_keys(competition, %w[id title rank year summary], context)
  raise "#{context} year must be an integer" unless competition["year"].is_a?(Integer)
  (competition["links"] || {}).each { |label, value| validate_link(value, "#{context} link #{label}") }
  preview_keys = %w[certificate_preview certificate_thumbnail]
  if preview_keys.any? { |key| competition[key] && competition[key] != "" }
    require_keys(competition, ["certificate"] + preview_keys, context)
    preview_keys.each do |key|
      preview = competition[key]
      raise "#{context} #{key} must use an absolute site path" unless preview.start_with?("/")
      preview_path = File.join(ROOT, preview.delete_prefix("/"))
      raise "#{context} #{key} file does not exist: #{preview}" unless File.file?(preview_path)
    end
  end
  certificate = competition["certificate"]
  next if certificate.nil? || certificate == ""

  validate_link(certificate, "#{context} certificate")
  certificate_path = File.join(ROOT, certificate.delete_prefix("/"))
  raise "#{context} certificate file does not exist: #{certificate}" unless File.file?(certificate_path)
end

%w[education honors service].each do |name|
  records = load_yaml(name)
  raise "#{name}.yml must contain a list" unless records.is_a?(Array)
end

honors = load_yaml("honors")
ensure_unique_ids(honors, "honors.yml")
honors.each_with_index do |honor, index|
  context = "honors.yml item #{index + 1}"
  require_keys(honor, %w[id title category featured], context)
  validate_link(honor["link"], "#{context} link")
  raise "#{context} featured must be true or false" unless [true, false].include?(honor["featured"])
  valid_year = honor["year"] == "" || honor["year"].is_a?(Integer) || honor["year"].to_s.match?(/\A\d{4}\.\d{2}\z/)
  raise "#{context} year must be an integer, YYYY.MM, or blank" unless valid_year
end

puts "Content data is valid."
