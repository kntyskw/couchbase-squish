class Link

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Callbacks
  extend ActiveModel::Naming

  attr_accessor :url, :key, :views, :session_id, :created_at

  define_model_callbacks :save
  validates :url, :presence => true, :url => {:allow_nil => true, :message => "This is not a valid URL"}
  before_save :generate_key

  def generate_key
    while self.key.nil?
      random = SecureRandom.hex(2)
      self.key = random if self.class.find(random).nil?
    end
  end

  # ActiveModel

  def initialize(attributes = {})
    @errors = ActiveModel::Errors.new(self)
    attributes.each do |name, value|
      setter = "#{name}="
      next unless respond_to?(setter)
      send(setter, value)
    end
    self.views ||= 0
    self.created_at ||= Time.zone.now
  end

  def to_param
    self.key
  end

  def persisted?
    return false unless (key && valid?)
    # TODO need a better way to track if an object is *dirty* or not...
    self.class.find(key).url == self.url
  end

  def save
    return false unless valid?
    run_callbacks :save do
      Couch.client.set(self.key, {
        :type => self.class.to_s.downcase,
        :url => self.url,
        :key => self.key,
        :views => self.views,
        :session_id => self.session_id,
        :created_at => self.created_at
      })
    end
  end

  def self.find(key)
    return nil unless key
    begin
      doc = Couch.client.get(key)
      self.new(doc)
    rescue Couchbase::Error::NotFound => e
      nil
    end
  end

end
