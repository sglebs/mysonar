# mysonar
This configures a Sonar that can be deployed to docker and therefore can be used locally to analyze your sources before commiting. You may want to comment out the plugins you do not need (for languages you do not use).


## Running SONAR

```
docker build -t mysonar .
docker run -it -p 9000:9000 mysonar
```
After SONAR finishes its bootstrapping, you should be able to visit: http://localhost:9000

## Analyzing your sources

First you need to create a sonar-project.properties file for your project to be analyzed:

```
# Required metadata
sonar.projectKey=foo:bar
sonar.projectName=Foo's Bar Project
sonar.projectVersion=1.0

# Path to the parent source code directory.
sonar.sources=.

# Encoding of the source code
sonar.sourceEncoding=ISO-8859-1
```

Then you run the analyzer (you will need sonar-runner):

```
/sonar-runner-2.4/bin/sonar-runner -e
```
