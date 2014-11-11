class PathsTest < ActiveSupport::TestCase
  test "assets are in path" do
    app = Rails.application
    assets = app.paths['vendor/assets'].to_ary
    paths = assets.select do |p|
      p[/ethereal/] 
    end

    assert(!paths.nil?, "Couldn't find path in assets")
    assert(paths.any?, "Couldn't find path in assets")
  end

  test "views are in path" do
    app = Rails.application
    assets = app.paths['app/views'].to_ary
    paths = assets.select do |p|
      p[/ethereal/] 
    end

    assert(!paths.nil?, "Couldn't find path in views")
    assert(paths.any?, "Couldn't find path in views")
  end

end
