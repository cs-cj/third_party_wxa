Dir["#{File.dirname(__FILE__)}/api/*.rb"].each do |path|
	# p path
  	require path
end
