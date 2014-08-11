fname = __FILE__.split('/').last
original = File.expand_path("../../../../../../app/lib/hello/#{fname}", __FILE__)
require original