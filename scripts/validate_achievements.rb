#!/usr/bin/env ruby

require "yaml"

ROOT = File.expand_path("..", __dir__)
MEDIA_ROOT = "/assets/img/achievements/"
ids = []

def required(record, keys, context)
  keys.each do |key|
    raise "#{context}: missing #{key}" if record[key].nil? || record[key] == ""
  end
end

def asset(path, context)
  unless path.is_a?(String) && path.start_with?(MEDIA_ROOT) && !path.split("/").include?("..")
    raise "#{context}: media must be stored under #{MEDIA_ROOT}"
  end
  raise "#{context}: missing file #{path}" unless File.file?(File.join(ROOT, path.delete_prefix("/")))
end

%w[competitions honors service].each do |name|
  records = YAML.load_file(File.join(ROOT, "_data", "#{name}.yml"))
  records.each do |record|
    context = "#{name}: #{record['id']}"
    required(record, %w[id], context)
    raise "#{context}: invalid id" unless record["id"].match?(/\A[a-z0-9]+(?:-[a-z0-9]+)*\z/)
    raise "#{context}: duplicate page anchor" if ids.include?(record["id"])
    ids << record["id"]
    if name == "honors"
      raise "#{context}: competition results belong in competitions.yml" if record["category"] == "competition"
      required(record, %w[description category_label], context)
    elsif name == "service"
      raise "#{context}: kind must be event or review" unless %w[event review].include?(record["kind"])
      required(record, %w[description], context) if record["kind"] == "event"
    end
    asset(record["certificate"], context) if record["certificate"] && record["certificate"] != ""
    gallery = record["gallery"] || []
    raise "#{context}: gallery must be a list" unless gallery.is_a?(Array)
    gallery.each_with_index do |photo, index|
      photo_context = "#{context}, image #{index + 1}"
      required(photo, %w[src alt caption], photo_context)
      asset(photo["src"], photo_context)
      asset(photo["thumbnail"], photo_context) if photo["thumbnail"]
      placeholder = photo.fetch("placeholder", false)
      raise "#{photo_context}: placeholder must be boolean" unless [true, false].include?(placeholder)
      if photo["src"].include?("/placeholders/") != placeholder
        raise "#{photo_context}: placeholder flag must match placeholder assets"
      end
    end
  end
end
puts "Achievement galleries are valid."
