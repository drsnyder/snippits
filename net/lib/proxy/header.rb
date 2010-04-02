

module Proxy
    module Header

        def self.parse(h)
            headers = Hash.new
            h.split("\r\n").drop(1).map do |line|
                key, value = line.split(': ')
                headers[key] = value
            end
            headers
        end

        def self.parse_by_line(s)
            headers = Hash.new
            lenght = 0
            loop do
                line = s.readline
                lenght += line.length
                break if line.length == 2
                key, value = line.rstrip.split(': ')
                headers[key] = value
            end

            headers
        end

    end

    module Body

        def self._read_nonblock(s, len)
            data = ''
            loop do
                begin
                    chunk = s.read_nonblock(len)
                rescue Errno::EAGAIN
                    IO.select([s])
                    retry
                rescue EOFError
                    break
                end

                data += chunk
                len -= chunk.length
                break if len == 0
            end
            
            data
        end

        def self.parse(h, s)
            if h.has_key?("Transfer-Encoding") and h["Transfer-Encoding"].downcase == "chunked"
                return Body.parse_chunked(h, s)
            else
                # not implemented yet
                # just get the content length and read that much more minus the
                # header
                return ""
            end
        end

        def self.parse_chunked(h_hash, s)
            data = ''
            loop do
                # begin 
                    hex_len = s.readline.slice(/[0-9a-fA-F]+/)
                # rescue EOFError
                #     break
                # end

                next_chunk_length = hex_len.hex
                break if next_chunk_length == 0

                chunk = self._read_nonblock(s, next_chunk_length)
                s.read 2 # /r/n

                data += chunk
            end

            h_hash['Content-Length'] = data.length
            h_hash.delete('Transfer-Encoding')
            return data, h_hash
        end

    end
end
