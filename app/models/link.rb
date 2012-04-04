class Link < Couchbase::Model

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Callbacks
  extend ActiveModel::Naming

  attribute :url, :views, :session_id, :created_at
  attribute :views, :default => 0
  attribute :created_at, :default => lambda { Time.zone.now }

  view :by_created_at, :by_session_id, :by_view_count

  define_model_callbacks :save
  validates :url, :presence => true, :url => {:allow_nil => true, :message => "This is not a valid URL"}
  before_save :generate_key

  def generate_key
    while self.id.nil?
      random = SecureRandom.hex(2)
      self.id = random if self.class.find_by_id(random).nil?
    end
  end

  def to_param
    self.id
  end

  def persisted?
    return false if new? || !valid?
    # TODO need a better way to track if an object is *dirty* or not...
    self.class.find_by_id(key).url == self.url
  end

  def save
    return false unless valid?
    run_callbacks :save do
      super
    end
  end

  def self.popular
    by_view_count(:descending => true).to_a
  end

  def self.my(session_id)
    by_session_id(:key => session_id).to_a
  end

  def self.recent
    by_created_at(:descending => true).to_a
  end

end
