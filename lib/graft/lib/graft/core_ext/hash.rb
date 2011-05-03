class Hash
  
  def /(path)
    path.to_s.split('/').inject(self) do |data, key|
      (data.is_a?(Hash) && data[key]) ? data[key] : nil
    end
  end
  
end