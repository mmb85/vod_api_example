class CatalogPresenter < Presenter
  def as_json(*)
    {
      catalog: @object.map { |o| CatalogPresenter.new(o)  }
    }
  end
end