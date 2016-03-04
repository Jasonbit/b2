module B2
  class Bucket < Base
    attr_accessor :bucket_id, :account_id, :bucket_name, :bucket_type, :buckets, :upload_url, :authorization_token, :files

    def create(bucket_name, bucket_type)
      body = {
        accountId: B2.account_id,
        bucketName: bucket_name,
        bucketType: bucket_type
      }
      response = post('/b2_create_bucket', body: body.to_json)
      assign_return_value(response)
    end

    def delete(bucket_id)
      body = {
        accountId: B2.account_id,
        bucketId: bucket_id
      }

      response = post('/b2_delete_bucket', body: body.to_json)
      assign_return_value(response)
    end

    def list
      body = {accountId: B2.account_id}

      response = post('/b2_list_buckets', body: body.to_json)
      assign_return_value(response)
    end

    def update_bucket(bucket_id, bucket_type)
      body = {
        accountId: B2.account_id,
        bucketId: bucket_id,
        bucketType: bucket_type
      }

      response = post('/b2_update_bucket', body: body.to_json)
      assign_return_value(response)
    end

    def get_upload_url(bucket_id)
      body = {
        bucketId: bucket_id
      }

      response = post('/b2_get_upload_url', body: body.to_json)
      assign_return_value(response)
    end

    def list_file_names(bucket_id, startFileName: nil, maxFileCount: nil)
      body = {
        bucketId: bucket_id
      }
      body.merge!(startFileName: startFileName) if startFileName
      body.merge!(maxFileCount: maxFileCount) if maxFileCount

      response = post('/b2_list_file_names', body: body.to_json)
      assign_return_value(response)
    end

    def list_file_versions(bucket_id, startFileName: nil, startFileId: nil, maxFileCount: nil)
      body = {
        bucketId: bucket_id
      }
      body.merge!(startFileName: startFileName) if startFileName
      body.merge!(maxFileCount: maxFileCount) if maxFileCount
      body.merge!(startFileId: startFileId) if startFileId

      response = post('/b2_list_file_versions', body: body.to_json)
      assign_return_value(response)
    end

    private
    def assign_return_value(response)
      if response.code.eql?(200)
        self.bucket_id = response["bucketId"]
        self.account_id = response["accountId"]
        self.bucket_name = response["bucketName"]
        self.bucket_type = response["bucketType"]
        self.buckets = response["buckets"]
        self.upload_url = response["uploadUrl"]
        self.authorization_token = response["authorizationToken"]
        self.files = response["files"]
      end
      response
    end
  end
end