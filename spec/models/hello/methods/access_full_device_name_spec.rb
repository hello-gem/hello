require 'spec_helper'

# Please help this project detect device names.
# All suggestions, issues and pull requests are welcome
#
# suggested sources:
# http://www.useragentstring.com/pages/useragentstring.php
# http://www.useragentstring.com/pages/Browserlist/
# http://www.useragentstring.com/pages/Chrome/
# http://www.webapps-online.com/online-tools/user-agent-strings

module Hello
  describe Access do

    before(:each) do
      @access = Access.new
    end

    def expect_device_name(original, expected)
      @access.user_agent_string = original
      expect(@access.full_device_name).to eq(expected)
    end

    describe "#full_device_name" do

      describe "Firefox" do
        it "Mac OS X 10 - Firefox 27" do
          expect_device_name  "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:27.0) Gecko/20100101 Firefox/27.0",
                              "Mac OS X 10 - Firefox 27"
        end
      end

      describe "Chrome" do
        describe "Desktop" do
          it "Mac OS X 10 - Chrome 34" do
            expect_device_name  "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.116 Safari/537.36",
                                "Mac OS X 10 - Chrome 34"
          end
        end
        describe "Mobile" do
          it "Android 4 (GT-I9300) - Chrome Mobile 30" do
            expect_device_name  "Mozilla/5.0 (Linux; Android 4.1.2; GT-I9300 Build/JZO54K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1599.92 Mobile Safari/537.36",
                                "Android 4 (Samsung GT-I9300) - Chrome Mobile 30"
          end
        end
        describe "OS" do
          it "Chrome OS 4537 - Chrome 30" do
            expect_device_name  "Mozilla/5.0 (X11; CrOS armv7l 4537.56.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1599.38 Safari/537.36",
                                "Chrome OS 4537 - Chrome 30"
          end
          it "Chrome OS 4731 - Chrome 31" do
            expect_device_name  "Mozilla/5.0 (X11; CrOS x86_64 4731.85.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36",
                                "Chrome OS 4731 - Chrome 31"
          end
        end
      end
      
      describe "Safari" do
        it "Mac OS X 10 - Safari 7" do
          expect_device_name  "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.75.14 (KHTML, like Gecko) Version/7.0.3 Safari/537.75.14",
                              "Mac OS X 10 - Safari 7"
        end
      end

      describe "Microsoft" do
        it "Windows 7 - Internet Explorer 10" do
          expect_device_name  "Mozilla/5.0 (compatible; MSIE 10.6; Windows NT 6.1; Trident/5.0; InfoPath.2; SLCC1; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; .NET CLR 2.0.50727) 3gpp-gba UNTRUSTED/1.0",
                              "Windows 7 - Internet Explorer 10"
        end
        it "Windows 7 - Internet Explorer 9" do
          expect_device_name  "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Win64; x64; Trident/5.0",
                              "Windows 7 - Internet Explorer 9"
        end
        it "Windows 7 - Internet Explorer 8" do
          expect_device_name  "Mozilla/5.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0; GTB7.4; InfoPath.2; SV1; .NET CLR 3.3.69573; WOW64; en-US)",
                              "Windows 7 - Internet Explorer 8"
        end
        it "Windows XP - Internet Explorer 7" do
          expect_device_name  "Mozilla/4.0 (compatible; MSIE 7.0b; Windows NT 5.1; Media Center PC 3.0; .NET CLR 1.0.3705; .NET CLR 1.1.4322; .NET CLR 2.0.50727; InfoPath.1)",
                              "Windows XP - Internet Explorer 7"
        end
        it "Windows Phone 8 (HTC) - Internet Explorer Mobile 10" do
          expect_device_name  "Mozilla/5.0 (compatible; MSIE 10.0; Windows Phone 8.0; Trident/6.0; IEMobile/10.0; ARM; Touch; HTC; Windows Phone 8X by HTC)",
                              "Windows Phone 8 (HTC) - Internet Explorer Mobile 10"
        end
        it "Windows Phone 8 (Lumia 620) - Internet Explorer Mobile 10" do
          expect_device_name  "Mozilla/5.0 (compatible; MSIE 10.0; Windows Phone 8.0; Trident/6.0; IEMobile/10.0; ARM; Touch; NOKIA; Lumia 620)",
                              "Windows Phone 8 (Lumia 620) - Internet Explorer Mobile 10"
        end
      end

      describe "Android" do
        it "Android 4 (LG-L160L) - Android 4" do  
          expect_device_name  "Mozilla/5.0 (Linux; U; Android 4.0.3; ko-kr; LG-L160L Build/IML74K) AppleWebkit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30",
                              "Android 4 (LG L160L) - Android 4"
        end
        it "Android 2 (T-Mobile myTouch 3G Slide) - Android 2" do  
          expect_device_name  "Mozilla/5.0 (Linux; U; Android 2.3.4; en-us; T-Mobile myTouch 3G Slide Build/GRI40) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1",
                              "Android 2 (T-Mobile myTouch 3G Slide) - Android 2"
        end
        it "Android 2 (HTC Vision) - Android 2" do
          expect_device_name  "Mozilla/5.0 (Linux; U; Android 2.3.5; en-us; HTC Vision Build/GRI40) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1",
                              "Android 2 (HTC Vision) - Android 2"
        end
        it "Android 4 (SAMSUNG GT-I9300/I9300XXEMRD) - Android 4" do  
          expect_device_name  "Mozilla/5.0 (Linux; U; Android 4.1.2; nl-nl; SAMSUNG GT-I9300/I9300XXEMRD Build/JZO54K) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30",
                              "Android 4 (Samsung GT-I9300) - Android 4"
        end
        it "Symbian OS 9 (Nokia 5800d-1) - Nokia Browser 7" do  
          expect_device_name  "Mozilla/5.0 (SymbianOS/9.4; Series60/5.0 Nokia5800d-1/60.0.003; Profile/MIDP-2.1 Configuration/CLDC-1.1 ) AppleWebKit/533.4 (KHTML, like Gecko) NokiaBrowser/7.3.1.33 Mobile Safari/533.4",
                              "Symbian OS 9 (Nokia 5800d-1) - Nokia Browser 7"
        end
      end

      describe "Linux" do
        it "Slackware 13.0 - Konqueror 4.2" do
          expect_device_name  "Mozilla/5.0 (compatible; Konqueror/4.2; Linux) KHTML/4.2.4 (like Gecko) Slackware/13.0",
                              "Slackware 13 - Konqueror 4"
        end
        it "Ubuntu - Other" do
          expect_device_name  "Mozilla/5.0 (Ubuntu; Mobile) WebKit/ 537.21",
                              "Ubuntu - Other"
        end
      end

      describe "TV" do
        it "Android 4.1.1 (POV_TV-HDMI-200BT) - Android 4.1.1" do
          expect_device_name  "Mozilla/5.0 (Linux; U; Android 4.1.1; nl-nl; POV_TV-HDMI-200BT Build/JRO03H) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Safari/534.30",
                              "Android 4 (POV_TV-HDMI-200BT) - Android 4"
        end
        it "Linux - WebKit Nightly 531.2" do
          expect_device_name  "Mozilla/5.0 (SmartHub; SMART-TV; U; Linux/SmartTV) AppleWebKit/531.2+ (KHTML, like Gecko) WebBrowser/1.0 SmartTV Safari/531.2+",
                              "Linux - WebKit Nightly 531"
        end
        it "Linux 2.6.35 (LG BDP) - Other" do
          expect_device_name  "LG-BDP Linux/2.6.35 UPnP/1.0 DLNADOC/1.50 LGE_DLNA_SDK/1.5.0",
                              "Linux 2 (LG BDP) - Other"
        end
        # NeoTV
        it "Android 3.2 (GTV100) - Android 3.2" do 
          expect_device_name  "Mozilla/5.0 (Linux; U; Android 3.2; en-us; GTV100 Build/MASTER) AppleWebKit/534.13 (KHTML, like Gecko) Version/4.0 Safari/534.13",
                              "Android 3 (GTV100) - Android 3"
        end
      end

  

  

  

  





      describe "Amazon Kindle" do
        it "Android 4 (Kindle Fire HDX 7\" WiFi) - Android 4" do
          expect_device_name  "Mozilla/5.0 (Linux; U; Android 4.2.2; en-us; KFTHWI Build/JDQ39) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Safari/534.30",
                              "Android 4 (Kindle Fire HDX 7\" WiFi) - Android 4"
        end
        it "Android 4 (Kindle Fire HDX 7\" WiFi) - Chrome 34" do
          expect_device_name  "Mozilla/5.0 (Linux; Android 4.2.2; KFTHWI Build/JDQ39) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.62 Safari/537.36",
                              "Android 4 (Kindle Fire HDX 7\" WiFi) - Chrome 34"
        end
      end

      describe "Blackberry" do
        it "BlackBerry OS 6 (BlackBerry 9650) - BlackBerry WebKit 6" do
          expect_device_name  "Mozilla/5.0 (BlackBerry; U; BlackBerry 9650; en-US) AppleWebKit/534.8+ (KHTML, like Gecko) Version/6.0.0.719 Mobile Safari/534.8+",
                              "BlackBerry OS 6 (BlackBerry 9650) - BlackBerry WebKit 6"
        end
        it "BlackBerry OS 5 (BlackBerry 8520) - BlackBerry 8520" do
          expect_device_name  "BlackBerry8520/5.0.0.681 Profile/MIDP-2.1 Configuration/CLDC-1.1 VendorID/120",
                              "BlackBerry OS 5 (BlackBerry 8520) - BlackBerry 8520"
        end
      end

      describe "Apple" do
        it "iOS 6 (iPad) - Mobile Safari 6" do
          expect_device_name  "Mozilla/5.0 (iPad; CPU OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5355d Safari/8536.25",
                              "iOS 6 (iPad) - Mobile Safari 6"
        end
        it "iOS 7 (iPad) - Chrome Mobile iOS 30" do
          expect_device_name  "Mozilla/5.0 (iPad; CPU OS 7_0 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) CriOS/30.0.1599.12 Mobile/11A465 Safari/8536.25 (3B92C18B-D9DE-4CB7-A02A-22FD2AF17C8F)",
                              "iOS 7 (iPad) - Chrome Mobile iOS 30"
        end
        it "iOS 7 (iPod) - Mobile Safari 7" do
          expect_device_name  "Mozilla/5.0 (iPod touch; CPU iPhone OS 7_0_3 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11B511 Safari/9537.53",
                              "iOS 7 (iPod) - Mobile Safari 7"
        end
        it "iOS 6 (iPhone) - Mobile Safari 6" do
          expect_device_name  "Mozilla/5.0 (iPhone; CPU iPhone OS 6_1_4 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10B350 Safari/8536.25",
                              "iOS 6 (iPhone) - Mobile Safari 6"
        end
        it "iTunes on Windows" do
          expect_device_name  "iTunes/9.0.2 (Windows; N)",
                              "Windows - Other"
        end
      end

      describe "Spiders" do
        
        describe "bingbot 2.0" do
          it "1" do
            expect_device_name  "Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)",
                                "Spider: bingbot 2"
          end
          it "2" do
            expect_device_name  "Mozilla/5.0 (compatible; bingbot/2.0 +http://www.bing.com/bingbot.htm)",
                                "Spider: bingbot 2"
          end
        end

        describe "Googlebot 2.1" do
          it "1" do
            expect_device_name  "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)",
                                "Spider: Googlebot 2"
          end
          it "2" do
            expect_device_name  "Googlebot/2.1 (+http://www.googlebot.com/bot.html)",
                                "Spider: Googlebot 2"
          end
          it "3" do
            expect_device_name  "Googlebot/2.1 (+http://www.google.com/bot.html)",
                                "Spider: Googlebot 2"
          end
        end

        describe "Baidu" do
          it "Baidu 1" do
            expect_device_name  "Baiduspider+(+http://www.baidu.com/search/spider_jp.html)",
                                "Spider: Other"
          end
          it "Baidu 2" do
            expect_device_name  "Baiduspider+(+http://www.baidu.com/search/spider.htm)",
                                "Spider: Other"
          end
          it "Baidu 3" do
            expect_device_name  "BaiDuSpider",
                                "Other - Other"
          end
        end

      end

    end

  end
end
