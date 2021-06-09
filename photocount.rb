require "uri"
require "net/http"
require "json"

img_arr = []
url = 'https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&api_key='
key = 'FcvswxMv5W64nMKaA5reHuCdCQJYeWqvDbqaeccg'

def request(url,key)
    address = url + key
    url = URI(address)    
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = https.request(request)
    JSON.parse response.read_body
end

body = request(url,key)
body['photos'].each do |photo|
    img = photo['img_src']
    img_arr.push(img)
end

def photo_count(body)
    cam_arr = []
    body['photos'].each do |photo|
        cam = photo['camera']['name']
        cam_arr.push(cam)
    end
    count = cam_arr.group_by{|x| x}.transform_values do |values|
        values.count
    end
    puts count
end
photo_count(body)

def build_web_page(array)
    html = "<html>\n\t<head>\n\t</head>\n\t<body>\n\t\t<ul>"
    array.each do |x|
        html += "\n\t\t\t<li><img src=#{x}></li>"
    end
    html += "\n\t\t</ul>\n\t</body>\n</html>"
    File.write('photos.html', html)
end
build_web_page(img_arr)