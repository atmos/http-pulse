module HttpPulse
  module Response
    class Monitor
      def initialize(json)
        @json = json
      end

      def url
        @json['url']
      end

      def up?
        @json['httpStatus'] == 200
      end

      def status
        up? ? "UP" : "DOWN"
      end

      def checked_at
        checked_at_time.strftime("%Y/%m/%d %H:%M %Z")
      end

      def checked_at_time
        Time.parse(@json['lastChecked']).localtime
      end

      def to_s
        "%-45s %5s as of %s" % [url, status, checked_at]
      end
    end
  end
end
