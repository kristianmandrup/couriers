class String
  def human
    self.gsub(/\//, ' ').gsub(/::/, ' ').humanize
  end

  def dhuman
    self.gsub(/\//, ' ').gsub(/::/, ' ').humanize.downcase
  end
end
