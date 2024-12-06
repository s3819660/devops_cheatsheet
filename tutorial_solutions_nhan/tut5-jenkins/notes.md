## Building steps

### 1. Create EC2 for Jenkins server:

- Allocate more disk space -> install Jenkins -> start the server on EC2 -> setup on GUI
- Install Git on EC2 -> add in Jenkins -> connect to remote GitHub repo
- Install Maven -> add in Jenkins -> build maven project

### 2. Create EC2 for Tomcat server:

- Install JDK17 -> setup Tomcat server hosting -> access via EC2

### 3. Connect:

- Jenkins server -> add Tomcat credentials
- Build maven project: add GitHub repo -> setup Maven build steps -> add Tomcat server info as container -> build

### 4. Auto deployment:
#### From Jenkins server
- Setup Poll SCM schedule on Jenkins

#### From GitHub repo
- Create Webhooks -> add Jenkins server's url/github-webhook/
- Add GitHub plugin on Jenkins (optional)
- Enable GitHub hook trigger in Jenkins' job configuration

### 5. Jenkins to private GitHub repo:
#### With token
- Create a PAT token on GitHub -> add in Jenkins' system credentials
- Add Git credentials in job config that connects to private repo
  
#### With ssh key pair
- Generate key pair from EC2 -> add the public to GitHub -> add private to Jenkins global credentials
- Update verification config on Jenkins sv
- Edit Jenkins job with ssh values

### 6. Testing

- Add test step before deployment
- Use script for testing the repo: check file, code, etc. -> exit if error
  Example script:

```
# Navigate to the cloned repository's location
cd $WORKSPACE

# Check if index.html exists
if [ ! -f src/main/webapp/index.jsp ]; then
    echo "Error: index.jsp not found!"
    exit 1
fi

# Search for a specific HTML component
if grep -q "<title>Hello DevOps Students!</title>" src/main/webapp/index.jsp; then
    echo "HTML component found!"
else
    echo "Error: HTML component not found!"
    exit 1
fi
```
