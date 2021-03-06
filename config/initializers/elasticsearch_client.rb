loaded_file = ERB.new(File.read("#{Rails.root}/config/elasticsearch.yml")).result
elasticsearch_config = YAML.load(loaded_file)[Rails.env].deep_symbolize_keys

Elasticsearch::Model.client = Elasticsearch::Client.new elasticsearch_config

Kaminari::Hooks.init
kaminari = Elasticsearch::Model::Response::Pagination::Kaminari

Elasticsearch::Model::Response::Response.__send__ :include, kaminari
