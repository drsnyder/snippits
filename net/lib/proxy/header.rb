

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

        def Header.parse_by_line(s)
            headers = Hash.new
            loop do
                line = s.readline
                break if line.length == 2
                key, value = line.rstrip.split(': ')
                headers[key] = value
            end
            headers
        end

    end

    module Body

        def Body.parse(h, body)
        end

        def Body.parse_chunked(h, body)
        end

    end
end
