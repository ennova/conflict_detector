require 'conflict_detector/version'

class ConflictDetector
  attr_accessor :model
  attr_accessor :names
  attr_accessor :status

  def initialize model, *names
    @model = model
    @names = names
  end

  # Checks if the model is a duplicate. Duplication is determined by finding
  # a record that matches the values of the attribute +names+.
  #
  # Returns the conflicting model if it is found, otherwise nil.
  def conflict
    record = model.class.where(conditions).first
    if record
      conflict!
      record
    end
  end

  def create
    created!
    model.save
    model
  end

  # Convenience method that attempts to save the model, detecting for a
  # conflict first.
  #
  # Returns conflicting record if conflicting record is found, otherwise
  # the created record.
  def conflicting_or_created_record
    conflict || create
  end

  protected

  def conditions
    names.inject({}) { |conditions, name| conditions.merge name => model.public_send(name) }
  end

  def conflict!
    @status = :conflict
  end

  def created!
    @status = :created
  end
end
