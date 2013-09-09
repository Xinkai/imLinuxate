exports.testcases =
    "Win XP 32bit Chrome 29":
        test:
            appVersion: "5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.66 Safari/537.36"
            platform: "Win32"
            oscpu: undefined
            userAgent: "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.66 Safari/537.36"
        against:
            appVersion: "5.0 (X11; Linux i686) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.66 Safari/537.36"
            platform: "Linux i686"
            oscpu: undefined
            userAgent: "Mozilla/5.0 (X11; Linux i686) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.66 Safari/537.36"

    "Win 2k8 R2 Chrome 29":
        test:
            appVersion: "5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.66 Safari/537.36"
            platform: "Win32"
            oscpu: undefined
            userAgent: "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.66 Safari/537.36"
        against:
            appVersion: "5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.66 Safari/537.36"
            platform: "Linux x86_64"
            oscpu: undefined
            userAgent: "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.66 Safari/537.36"
      
    "Win XP 32bit Firefox 23": 
        test: 
            appVersion: "5.0 (Windows)"
            platform: "Win32"
            oscpu: "Windows NT 5.1"
            userAgent: "Mozilla/5.0 (Windows NT 5.1; rv:23.0) Gecko/20100101 Firefox/23.0"
        against: 
            appVersion: "5.0 (X11)"
            platform: "Linux i686"
            oscpu: "Linux i686"
            userAgent: "Mozilla/5.0 (X11; Linux i686; rv:23.0) Gecko/20100101 Firefox/23.0"

    "Win 2k8 R2 Firefox 23":
        test:
            appVersion: "5.0 (Windows)"
            platform: "Win32"
            oscpu: "Windows NT 6.1; WOW64"
            userAgent: "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:23.0) Gecko/20100101 Firefox/23.0"
        against:
            appVersion: "5.0 (X11)"
            platform: "Linux x86_64"
            oscpu: "Linux x86_64"
            userAgent: "Mozilla/5.0 (X11; Linux x86_64; rv:23.0) Gecko/20100101 Firefox/23.0"

    "OSX 10.8 Chrome 29": 
        test: 
            undefined
        against:
            undefined
        
    "OSX 10.8 Firefox 23":
        test:
            undefined
        against:
            undefined
