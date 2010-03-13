

module Proxy
    module Header

        def Header.parse(h)
            headers = Hash.new
            h.split("\r\n").drop(1).map do |line|
                key, value = line.split(': ')
                headers[key] = value
            end
            headers
        end

    end
end
