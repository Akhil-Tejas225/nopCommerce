pipeline{
    agent any
    options {
        // Timeout counter starts AFTER agent is allocated
        timeout(time: 900, unit: 'SECONDS')
    } 
    triggers{
        pollSCM('* * * * *')
    }
  stages{    
    stage('git') {
      steps{
        git url: 'https://github.com/Akhil-Tejas225/nopCommerce.git',
        branch: 'develop' 
    }
      }
        
    stage('build'){
      agent {
         node {
            label 'dotnet'
         }
       }
        tools {
        dotnetsdk 'DOTNET_HOME'
    }
      steps{
        script {
           def projectpath = sh(script: "find . -name Nop.Web.csproj", returnStdout: true).trim()
           dotnetPublish configuration: 'Release', outputDirectory: 'published', project: "$projectpath"
        } 
                                 
      }
    
  }
    }

   
}

   
  //   stage('git') {
  //     steps{
  //       git url: 'https://github.com/Akhil-Tejas225/nopCommerce.git',
  //       branch: 'develop' 
  //   }
  //     }
        
  //   stage('build'){
  //     agent {
  //        node {
  //           label 'dotnet'
  //        }
  //      }
  //       tools {
  //       dotnetsdk 'DOTNET_HOME'
  //   }
  //     steps{
  //       // def projectpath = sh(script: "find . -name Nop.Web.csproj", returnStdout: true).trim()
      
  //       dotnetPublish configuration: 'Release', outputDirectory: 'published', project: '*/src/Nop.Web/Nop.Web.csproj'
                        
  //     }
    
  // }