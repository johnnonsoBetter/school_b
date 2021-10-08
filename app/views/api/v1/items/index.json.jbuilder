json.array! @items do |item|

    json.(item, :id, :name, :selling_price)

end