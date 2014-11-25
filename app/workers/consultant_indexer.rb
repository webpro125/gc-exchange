class ConsultantIndexer
  include Sidekiq::Worker
  sidekiq_options queue: 'elasticsearch', unique: true

  def perform(operation, record_id)
    logger.debug [operation, "ID: #{record_id}"]

    case operation.to_s
    when /update/
      record = Consultant.find(record_id)
      record.__elasticsearch__.index_document
    when /destroy/
      Consultant.__elasticsearch__.client.delete index: Consultant.index_name,
                                                 type: Consultant.document_type,
                                                 id: record_id
    else fail ArgumentError, "Unknown operation '#{operation}'"
    end
  end
end
