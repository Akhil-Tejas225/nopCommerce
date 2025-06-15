pipeline{
    agent any
    options {
        // Timeout counter starts AFTER agent is allocated
        timeout(time: 30, unit: 'SECONDS')
    } 
    triggers{
        pollSCM('* * * * *')
    }
  stages{
    agent {
         node {
            label 'dotnet'
         }
    }
    tools {
        maven 'DOTNET_HOME'
    }
    stage('git') {
        git url: 'https://github.com/Akhil-Tejas225/nopCommerce.git',
        branch: 'develop' 
    }
    stage('build'){
      steps{
        dotnetPublish configuration: 'Release', outputDirectory: 'published', project: $(find . -name Nop.Web.csproj)
                        
      }
    
  }
  } 
}