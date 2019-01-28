# TI API Testing

## LocalDev Setup

If you are able to use Docker, I recommend using Lando (https://docs.devwithlando.io/) to set up your local development environment.

If you are not able to use Docker, use these instructions to set up a local development environment with Vagrant.

### Download the TI API Testing project

Choose the directory where you want this project to live. For example, `your-projects/`.

Current directory: `your-projects/`

`git clone ssh://codeserver.dev.dc46e4c1-6782-402e-94b3-cace5ef93b3d@codeserver.dev.dc46e4c1-6782-402e-94b3-cace5ef93b3d.drush.in:2222/~/repository.git ti-api-testing`

### Start VM

`cd your-projects/ti-api-testing/localDev`

`vagrant up`

This will take a while. Once the process completes, you should be able to access [http://dashboard.ti-api-testing.local/](http://dashboard.ti-api-testing.local/) in your web browser.

**Note:** If the `vagrant up` doesn't complete successfully, try running it one or two more times. Sometimes these failures are caused by missing dependencies, which vagrant will install automatically so that it doesn't fail the next time it is run.

### Create settings.local.php

Current directory: `your-projects/ti-api-testing`

`cp sites/example.settings.local.php sites/default/settings.local.php`

Open `settings.local.php` in a text editor and add the following code to the bottom of the file.

```
$databases['default']['default'] = array (
  'database' => 'drupal',
  'username' => 'drupal',
  'password' => 'drupal',
  'prefix' => '',
  'host' => 'localhost',
  'port' => '3306',
  'namespace' => 'Drupal\\Core\\Database\\Driver\\mysql',
  'driver' => 'mysql',
);
$settings['hash_salt'] = 'some_random_string';
```

At this time, you can also modify other development settings such as disabling the cache.

When you're done modifying the file, save your changes.

### Sync DB and Files from Pantheon

The next step is to copy the DB and Files from Pantheon into your localDev environment.

#### Step 1: Download Database

Go to [dashboard.pantheon.io](https://dashboard.pantheon.io/sites/dc46e4c1-6782-402e-94b3-cace5ef93b3d)
and navigate to the environment that has the database you would like to
clone (usually Live).

Use the button in the upper right of the dashboard
to clear the cache. This will greatly reduce the database size and make
export/import easier.

Click `Database / Files` in the sidebar and go to `Export`. Create a new Database export.

Once the export is complete, download it.

#### Step 2: Import Database

Go to [http://adminer.ti-api-testing.local](http://adminer.ti-api-testing.local/index.php) and log in with the following credentials:

```
username: drupal
password: drupal
database: drupal
```

Go to [http://adminer.ti-api-testing.local/index.php?username=drupal&db=drupal&import=](http://adminer.ti-api-testing.local/index.php?username=drupal&db=drupal&import=) and click the "choose files" button in the **File Upload** section.

Choose the database export you just downloaded. It should end with the extension `.sql.gz`.

Click the "execute" button.

#### Step 3: Download Files

Go to [dashboard.pantheon.io](https://dashboard.pantheon.io/sites/dc46e4c1-6782-402e-94b3-cace5ef93b3d)
and navigate to the environment that has the files you would like to
clone (usually Live).

Click `Database / Files` in the sidebar and go to `Export`. Create a new Files export.

Once the export is complete, download it.

The downloaded file will end in `.tar.gz` and must be extracted twice before
you can use it in your project. (If you're on Windows you'll need [7-Zip](http://www.7-zip.org/) to extract the files.)

#### Step 4: Import Files

Once you have the extracted files, copy the contents and put it in the following directory: `your-projects/ti-api-testing/sites/default/files`

(If the "files" directory doesn't exist, create it first. If you get a prompt asking if you want to merge files or replace existing files, say yes.)

#### Step 5: Clear Cache

Current directory: `your-projects/ti-api-project/localDev`

`vagrant ssh`

`cd ~/var/www/ti-api-project`

`drush cache-rebuild`

`exit`

**Finally, if you go to [http://ti-api-testing.local/](http://ti-api-testing.local/), you should see the full site, completely set up.**

-------------------------------------------------------------------------------

If you have any questions or run into any issues, please contact [steigen@theinstitutes.org](mailto:steigen@theinstitutes.org)
