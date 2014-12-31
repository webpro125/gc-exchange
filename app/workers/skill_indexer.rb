class SkillIndexer
  include Sidekiq::Worker
  sidekiq_options queue: 'elasticsearch', unique: true

  def perform(operation, record_id)
    logger.debug [operation, "ID: #{record_id}"]

    case operation.to_s
    when /update/
      record = Skill.find(record_id)
      record.__elasticsearch__.index_document
    when /destroy/
      Skill.__elasticsearch__.client.delete index: Skill.index_name,
                                            type: Skill.document_type,
                                            id: record_id
    else fail ArgumentError, "Unknown operation '#{operation}'"
    end
  end
end
