module B2
  class Doc < Base
    attr_accessor :bucket_id, :account_id, :content_length, :content_sha1, :content_type, :file_id, :filename, :file_info

    def create(upload_url, file, authorization_token, folder: nil, content_type: 'b2/x-auto', info: {})
      if file.respond_to?(:read)
        content_type = file.content_type
        size = file.size.to_s
        filename = folder.nil? ? ERB::Util.url_encode(file.original_filename) : "#{folder}/#{ERB::Util.url_encode(file.original_filename)}"
        digest = Digest::SHA1.file(file.path).hexdigest
        body = file.read
      elsif file.is_a?(String)
        size = File.size(file).to_s
        filename = folder.nil? ? ERB::Util.url_encode(File.basename(file)) : "#{folder}/#{ERB::Util.url_encode(File.basename(file))}"
        digest = Digest::SHA1.file(file).hexdigest
        body = File.read(file)
      else
        raise ArgumentError.new('Unsuitable data type. Please read the docs.')
      end

      additional_headers = {}
      info.first(10).each do |key, value|
        additional_headers["X-Bz-Info-#{key}"] = value
      end

      headers = {
        "Authorization" => authorization_token,
        "Content-Type" => content_type,
        "X-Bz-File-Name" => filename,
        "Content-Length" => size,
        "X-Bz-Content-Sha1" => digest
      }

      headers.merge!(additional_headers)

      response = HTTParty.post(upload_url, body: body, headers: headers)
      assign_return_value(response)
    end

    def delete_file_version(filename, file_id)
      body = {
        fileName: filename,
        fileId: file_id
      }
      response = post('/b2_delete_file_version', body: body.to_json)
      assign_return_value(response)
    end

    def get_download_url(bucket_name, filename)
      "#{self.download_url}/file/#{bucket_name}/#{filename}"
    end

    def download_file_by_id(file_id)
      get("#{self.download_url}/b2api/v1/b2_download_file_by_id?fileId=#{file_id}")
    end

    def download_file_by_name(bucket_name, filename)
      get("#{self.download_url}/file/#{bucket_name}/#{filename}")
    end

    private
    def assign_return_value(response)
      if response.code.eql?(200)
        self.bucket_id = response["bucketId"]
        self.account_id = response["accountId"]
        self.content_length = response["contentLength"]
        self.content_sha1 = response["contentSha1"]
        self.content_type = response["contentType"]
        self.file_id = response["fileId"]
        self.file_info = response["fileInfo"]
        self.filename = response["fileName"]
      end
      response
    end
  end
end