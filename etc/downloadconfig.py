import os
import urllib.request as req
import base64
import json

baseURI = "https://api.github.com"
ghUser = os.environ.get['GITHUB_USER']
ghRepo = os.environ.get['GITHUB_REPO']
containerName = os.environ.get['CONFIG_NAME']
authHeaderBytes = base64.b64encode((ghUser + ":" + os.environ.get['GITHUB_AUTH']).encode('ascii'))
authHeader = authHeaderBytes.decode('ascii')

def main() :
    #Get latest release
    #From release get zipfile that matches thie CONFIG env var passed to this container
    #Clear the env var that stores the key
    latestRelease = getWithBasicAuth("{0}/repos/{1}/{2}/releases/latest".format(baseURI,ghUser,ghRepo),authHeader)
    releaseJson = json.load(latestRelease)
    
    print(os.getcwd())

    for asset in releaseJson['assets'] :
        if asset['name'] == (containerName + ".zip") :
            print("Found Matching Asset")
            configArchiveStream = downloadConfig(asset['url'], authHeader)
            f = open("{0}/{1}.zip".format(os.getcwd(),containerName),'w+b')
            f.write(configArchiveStream.read())
            print("Zip File Dropped")

def getWithBasicAuth (requestUri, headerToken) :
    headers = { 'Authorization' : ('basic ' + headerToken)}
    thisRequest = req.Request(url=requestUri, headers=headers)
    print("Getting Latest Release")
    return req.urlopen(thisRequest)

def downloadConfig (requestUri, headerToken) :
    headers = { 'Authorization' : ('basic ' + headerToken),
                'Accept': 'application/octet-stream'}
    thisRequest = req.Request(url=requestUri, headers=headers)
    print("Downloading config")
    return req.urlopen(thisRequest)


if __name__ == "__main__" :
    main()
