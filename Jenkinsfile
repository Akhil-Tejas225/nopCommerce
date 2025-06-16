pipeline{
    agent any
    options {
        // Timeout counter starts AFTER agent is allocated
        timeout(time: 900, unit: 'SECONDS')
    } 
    triggers{
        pollSCM('* * * * *')
    }
    parameters {
       choice(name: 'CHOICES', choices:['build','publish'], description: 'dotnet lifecycle commands')
    }
  stages{    
    stage('git') {
      steps{
        git url: 'https://github.com/Akhil-Tejas225/nopCommerce.git',
        branch: 'develop' 
    }
      }
        
    stage('build'){
      when {
        expression {
          beforeAgent true
          params.CHOICES == 'build' || params.CHOICES == 'publish'
        }
      }
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
           def projectpath = sh(script: "find . -name Nop.Web.csproj", returnStdout: true).trim()    // script{} is of groovy style adopted by me (akhil) to ensure avoid giving complete path of the csproj file
           dotnetPublish configuration: 'Release', outputDirectory: 'published', project: "$projectpath" 
          
        }  
    } 
      post{
        success{
          zip zipFile: 'published.zip', 
            archive: true, 
            dir: './published', 
            overwrite: true
        }
      }
}  
}
}

//Lesson learnt: ensure agent and tools are part of same stage where you are running the build
