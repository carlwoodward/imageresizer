class CachingResizer
  attr_accessor :url, :dimensions
  
  def initialize(url, dimensions)
    @url = url
    @dimensions = dimensions
  end
  
  def find_in_cache_or_resize
    make_cache_dir
    file = get_from_cache
    file ||= resize_and_save
    send_file file
  end
  
  # protected
  
  def get_from_cache
    
  end
  
  def resize
    MiniMagick::Image.from_blob open(@url).read
    img.resize dimensions
  end

  def cache_dir
    "/cache/#{domain_dir}"
  end
  
  def domain_dir
    @url =~ /http:\/\/(.+)\//
    $1
  end

  def make_cache_dir
    FileUtils.mkdir cache_dir unless File.exists?(cache_dir)
  end

  def file_name
    @file_name ||= (@url + '_' + @dimensions).gsub(/\/|\:|\?|\.| |_/, '-')
  end
end