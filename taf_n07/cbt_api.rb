require "selenium-webdriver"
require "rest-client"
require "test-unit"

class CBT_API
    @@username = 'user'
    @@authkey = 'key'
    @@BaseUrl =   "https://#{@@username}:#{@@authkey}@crossbrowsertesting.com/api/v3"
    
    def getSnapshot(sessionId)
        # this returns the the snapshot's "hash" which is used in the
        # setDescription function
        response = RestClient.post(@@BaseUrl + "/selenium/#{sessionId}/snapshots",
            "selenium_test_id=#{sessionId}")
        snapshotHash = /(?<="hash": ")((\w|\d)*)/.match(response)[0]
        return snapshotHash
    end

    def setDescription(sessionId, snapshotHash, description)
        response = RestClient.put(@@BaseUrl + "/selenium/#{sessionId}/snapshots/#{snapshotHash}",
            "description=#{description}")
    end

    def setScore(sessionId, score)
        # valid scores are 'pass', 'fail', and 'unset'
        response = RestClient.put(@@BaseUrl + "/selenium/#{sessionId}",
            "action=set_score&score=#{score}")
    end
end