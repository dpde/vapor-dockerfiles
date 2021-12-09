# Vapor Dockerfiles Using Debian

The Dockerfiles provided with this repository use Debian Buster instead of Alpine Linux, which made further customization a lot easier for me.

See [Laravel Vapor documentation](https://docs.vapor.build/1.0/projects/environments.html#runtime) on how to use a docker based runtime.

## Dockerhub

The images are published to the following repository on Dockerhub: [denizp/vapor](https://hub.docker.com/repository/docker/denizp/vapor)

## Available Images

### Default Debian Buster

```
FROM denizp/vapor:php81-buster

COPY . /var/task
```

### Puppeteer and [spatie/browsershot](https://github.com/spatie/browsershot)

#### Vapor environment dockerfile

```
FROM denizp/vapor:php81-buster-puppeteer

COPY . /var/task
```

#### Chromium Arguments

Tested and it works with the following Chromium arguments.

```
no-sandbox
single-process
disable-dev-shm6-usage
disable-gpu
no-zygote
```

```php
$browsershot = new Browsershot('');
$browsershot
    ->noSandbox()
    ->waitUntilNetworkIdle();

if (app()->environment() !== 'local') {
    $browsershot->addChromiumArguments([
        'single-process',
        'disable-dev-shm6-usage',
        'disable-gpu',
        'no-zygote'
    ]);
}
```
