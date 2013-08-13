module RighteousGitHooks
	class Result
		def initialize(message, status_code)
			throw "You must supply both message and status_code" if message.to_s == "" or status_code.to_s == ""
			throw "Status code must be either 0 or 1" unless [0,1].include? status_code
			@message = message
			@status_code = status_code
		end

		attr_reader :message
		attr_reader :status_code

		def self.success(message)
			Result.new(message, 0)
		end

		def self.error(message)
			Result.new(message, 1)
		end
	end
end