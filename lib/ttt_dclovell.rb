Dir[File.expand_path("../ttt/**/*.rb", __FILE__)].each { |file| require file }
class TttDclovell
  VERSION = '0.5.0'

  def self.play
    controller = MasterController.new
    controller.play
  end
end
