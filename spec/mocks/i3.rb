class I3IpcMock
  def close
    true
  end

  def workspaces
    @workspaces ||= [WorkspaceMock.new(1, "a"), WorkspaceMock.new(2, "2: b"), WorkspaceMock.new(3, "c", true)]
  end
end

class WorkspaceMock
  attr_accessor :focused, :name, :num

  def initialize(num, name, focused=false)
    @focused = focused
    @num = num
    @name = name
  end
end
