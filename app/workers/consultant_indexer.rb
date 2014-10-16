class ConsultantIndexer
  include Sidekiq::Worker
  sidekiq_options queue: 'elasticsearch', retry: false, unique: true

  def perform(operation, record_id)
    logger.debug [operation, "ID: #{record_id}"]

    record = Consultant.find(record_id)

    case operation.to_s
    when /update/
      record.index_document
    when /destroy/
      record.delete_document
    else fail ArgumentError, "Unknown operation '#{operation}'"
    end
  end
end
