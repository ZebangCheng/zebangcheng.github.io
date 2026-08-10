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

profile = load_yaml("profile")
raise "profile.yml must contain a mapping" unless profile.is_a?(Hash)
require_keys(profile, %w[name title email_display], "profile.yml")

news = load_yaml("news")
raise "news.yml must contain a list" unless news.is_a?(Array)
news.each_with_index do |item, index|
  require_keys(item, %w[date text], "news.yml item #{index + 1}")
end

publications = load_yaml("publications")
raise "publications.yml must contain a list" unless publications.is_a?(Array)
titles = {}
publications.each_with_index do |publication, index|
  context = "publications.yml item #{index + 1}"
  require_keys(publication, %w[title authors venue year selected], context)
  title = publication["title"]
  raise "Duplicate publication title: #{title}" if titles[title]
  titles[title] = true

  next unless publication["selected"]

  links = publication["links"]
  raise "#{context} must include at least one link" unless links.is_a?(Hash) && links.values.any? { |value| value && value != "" }
end

%w[education honors service].each do |name|
  records = load_yaml(name)
  raise "#{name}.yml must contain a list" unless records.is_a?(Array)
end

puts "Content data is valid."
