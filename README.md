### Docker config to setup XO which is a web interface to visualize and administrate your XenServer (or XAPI enabled) hosts

See https://xen-orchestra.com for information on Xen Orchestra

![main_view](https://cloud.githubusercontent.com/assets/862951/6341155/b4d5b9da-bc1b-11e4-8352-a1688c571e5b.png)

## Running the app

#### From Docker Hub

```
docker pull sammcj/docker-xen-orchestra
docker run -d -p 8000:80 sammcj/docker-xen-orchestra
```

### Building

```
git clone https://github.com/sammcj/docker-xen-orchestra.git
cd docker-xen-orchestra
# Edit whatever config you want to change
docker build -t xen-orchestra .
```

## SSL

Always use SSL in production or when transmitting sensitive information during testing.
For example you could:

1) Run Nginx in front of the container to provide SSL

2) Edit the sample config to point to your certificates which you will add into the image (be careful with this)
See https://github.com/vatesfr/xo-server/blob/master/sample.config.yaml for available options

### Support

* This Docker project is not supported by Xen-Orchestra or the parent company Vates.
* Xen-Orchestra also provides a fully-supported, turn-key appliance, see: https://xen-orchestra.com/pricing.html

#### TODO

* See issues

Please consider supporting Xen-Orchestra, it's a great product with a bright future.

_Pull requests appreciated!_
