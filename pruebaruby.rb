require "uri"
require "net/http"
require "json"

def request(address)
    url = URI(address)
    # URI("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&page=2&api_key=DZpvfca9ZYKiJ15VAUv1Cker22vtnl9Awa8b4coa")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)

    response = https.request(request)

    body = JSON.parse response.read_body
end

body = request('https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&page=2&api_key=DZpvfca9ZYKiJ15VAUv1Cker22vtnl9Awa8b4coa')

body.each do |photo,id|
    puts id

    # html += "img src=\"#{img_src}"

end




# def filter(id) filtar con each

#     new_array = []
#     array.each do |ele|
#         if ele
#         new_array.push(ele)
#         end
#     end
#     print new_array #devolvemos el arreglo nuevo
# end


def buil_web_page
    pic.each do |img|
        html = "<html>\n<head>\n</head>\n<body>\n<ul style='list-style-type: none;'>\n"
        html +="\t<li><img src=\"#{response["img_src"]}\">#{response["id"]}</li>\n"
        html += "</ul>\n</body>\n</html>"
    end
        File.write("nasa.html", html)
end