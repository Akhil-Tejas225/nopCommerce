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
    stage('declare_agent'){
       agent {
         node {
            label 'dotnet'
         }
       }
        tools {
        dotnet 'DOTNET_HOME'
    }
       steps{
        echo "declaring agent"
       }
    
    }
   
    stage('git') {
      steps{
        git url: 'https://github.com/Akhil-Tejas225/nopCommerce.git',
        branch: 'develop' 
    }
      }
        
    stage('build'){
      steps{
        // def projectpath = sh(script: "find . -name Nop.Web.csproj", returnStdout: true).trim()
        dotnetPublish configuration: 'Release', outputDirectory: 'published', project: '*/src/Nop.Web/Nop.Web.csproj'
                        
      }
    
  }
  } 
}