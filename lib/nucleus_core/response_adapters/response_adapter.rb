require "nucleus_core/simple_object"

class NucleusCore::ResponseAdapter < NucleusCore::SimpleObject
  def initialize(attrs={})
    attributes = defaults
      .merge(attrs)
      .slice(*defaults.keys)
      .tap do |hash|
        hash[:status] = status_code(hash[:status])
      end

    super(attributes)
  end

  private

  def defaults
    {
      content: nil,
      headers: nil,
      status: nil,
      location: nil
    }
  end

  def status_code(status=nil)
    status = Utils.status_code(status)
    default_status = 200

    status.zero? ? default_status : status
  end
end
