module Current
  thread_mattr_accessor :user

  def self.reset!
    all_attrs = Thread.current.keys.select{|a| a.to_s.starts_with?('attr_Current_')}
    all_attrs.each do |attr|
      attr = attr.to_s.gsub('attr_Current_','')
      self.send("#{attr}=", nil)
    end
  end
end