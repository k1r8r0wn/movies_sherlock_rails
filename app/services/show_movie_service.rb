class ShowMovieService
  def initialize(args)
    # { title => "Title" ...}
    args.each do |method_name, value|
      self.class.send(:define_method, method_name.to_s) { value }
    end
  end
end
