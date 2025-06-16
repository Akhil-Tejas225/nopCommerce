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
        dir('nopcommerce') {     
        git url: 'https://github.com/Akhil-Tejas225/nopCommerce.git',
        branch: 'develop'
        }
        
    }
      }
        
    stage('build'){
      when {
        beforeAgent true
        expression {
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
// when is conditional that is used to control  stage execution.When comes along with boolean conditions like beforeAgent <true/false> beforeinput <true/false> beforeoptions <true/false> 
// research
// Chat history

// You said:
// can I parameterize this "ipeline{
//     agent any
//     options {
//         // Timeout counter starts AFTER agent is allocated
//         timeout(time: 900, unit: 'SECONDS')
//     } 
//     triggers{
//         pollSCM('* * * * *')
//     }
//     parameters {
//        choice(name: 'CHOICES', choices:['build','package'], description: 'dotnet lifecycle commands')
//     }
//   stages{    
//     stage('git') {
//       steps{
//         git url: 'https://github.com/Akhil-Tejas225/nopCommerce.git',
//         branch: 'develop' 
//     }
//       }
        
//     stage('build'){
//       agent {
//              node {
//                label 'dotnet'
//          }   
//        }
//         tools {
//         dotnetsdk 'DOTNET_HOME'
//     }
//       steps{
//         script {
//            def projectpath = sh(script: "find . -name Nop.Web.csproj", returnStdout: true).trim()    // script{} is of groovy style adopted by me (akhil) to ensure avoid giving complete path of the csproj file
//            dotnetPublish configuration: 'Release', outputDirectory: 'published', project: "$projectpath" 
          
//         }  
//     } 
//       post{
//         success{
//           zip zipFile: 'published.zip', 
//             archive: true, 
//             dir: './published', 
//             overwrite: true
//         }
//       }
// }  
// }
// }
// "
// ChatGPT said:
// Absolutely, Akhil! 💡 You can parameterize the Jenkins declarative pipeline to conditionally run stages based on the value of the parameter (CHOICES in your case). This is a great way to control execution without duplicating pipeline logic.

// Here's how to do it smartly:

// ✅ Updated Parameterized Pipeline
// pipeline {
//     agent any

//     options {
//         timeout(time: 900, unit: 'SECONDS')
//     }

//     triggers {
//         pollSCM('* * * * *')
//     }

//     parameters {
//         choice(name: 'CHOICES', choices: ['build', 'package'], description: 'dotnet lifecycle commands')
//     }

//     stages {
//         stage('git') {
//             steps {
//                 git url: 'https://github.com/Akhil-Tejas225/nopCommerce.git', branch: 'develop'
//             }
//         }

//         stage('Build and Package') {
//             when {
//                 expression {
//                     return params.CHOICES == 'build' || params.CHOICES == 'package'
//                 }
//             }
//             agent {
//                 node {
//                     label 'dotnet'
//                 }
//             }
//             tools {
//                 dotnetsdk 'DOTNET_HOME'
//             }
//             steps {
//                 script {
//                     def projectpath = sh(script: "find . -name Nop.Web.csproj", returnStdout: true).trim()
//                     dotnetPublish configuration: 'Release', outputDirectory: 'published', project: "${projectpath}"
//                 }
//             }
//             post {
//                 success {
//                     script {
//                         if (params.CHOICES == 'package') {
//                             zip zipFile: 'published.zip',
//                                 archive: true,
//                                 dir: './published',
//                                 overwrite: true
//                         }
//                     }
//                 }
//             }
//         }
//     }
// }
// 🧠 What Changed and Why?
// Section	Description
// parameters	Adds CHOICES for 'build' and 'package'.
// when block	Controls when the stage runs, based on selected choice.
// post condition	Runs zip only if 'package' is selected, keeping builds lightweight when not needed.
// 🤹‍♂️ Sample Usage
// build → Only compiles and publishes output.

// package → Compiles + publishes + zips the output folder.

// If you want to split build and package into separate stages, let me know — I’ll show you a slick version with when blocks on each stage. 😎

// You said:
// explain conditional exectution usage in jenkins also explain uage of allof anyof not and try to apply to above example
// ChatGPT said:
// Great ask, Akhil! Conditional execution in Jenkins pipelines gives you precise control over what runs, when, and why — like having if-else logic but declaratively. Let's break it down and apply it to your pipeline like a true DevOps ninja 🥷.

// 💡 Conditional Execution in Jenkins (when block)
// The when directive in Jenkins declarative pipelines is used to conditionally execute a stage.

// 🔧 Syntax Overview:
// when {
//     // conditions here
// }
// 🧱 Supported Conditions:
// Condition	Description
// branch	Executes stage if branch matches
// expression	Executes if a Groovy expression evaluates to true
// equals	Matches a parameter or environment variable
// environment	Checks the environment variable
// not	Negates a condition
// allOf	All nested conditions must be true (logical AND)
// anyOf	At least one nested condition must be true (logical OR)
// 🔄 Logical Conditions
// allOf
// when {
//     allOf {
//         branch 'develop'
//         expression { return params.CHOICES == 'build' }
//     }
// }
// ✔️ Executes only if both conditions are met.

// anyOf
// when {
//     anyOf {
//         branch 'develop'
//         branch 'main'
//     }
// }
// ✔️ Executes if at least one branch matches.

// not
// when {
//     not {
//         branch 'master'
//     }
// }
// ✔️ Executes if branch is NOT master.

// 🧠 Now, Applying All These to Your Pipeline
// Let’s split the logic smartly into two stages — Build and Package — and use these conditional expressions.

// ✅ Final Example with allOf, anyOf, not, and expression
// pipeline {
//     agent any

//     options {
//         timeout(time: 900, unit: 'SECONDS')
//     }

//     triggers {
//         pollSCM('* * * * *')
//     }

//     parameters {
//         choice(name: 'CHOICES', choices: ['build', 'package'], description: 'dotnet lifecycle commands')
//     }

//     stages {
//         stage('git') {
//             steps {
//                 git url: 'https://github.com/Akhil-Tejas225/nopCommerce.git', branch: 'develop'
//             }
//         }

//         stage('Build') {
//             when {
//                 allOf {
//                     branch 'develop'
//                     expression { params.CHOICES == 'build' || params.CHOICES == 'package' }
//                 }
//             }
//             agent {
//                 node {
//                     label 'dotnet'
//                 }
//             }
//             tools {
//                 dotnetsdk 'DOTNET_HOME'
//             }
//             steps {
//                 script {
//                     def projectpath = sh(script: "find . -name Nop.Web.csproj", returnStdout: true).trim()
//                     dotnetPublish configuration: 'Release', outputDirectory: 'published', project: "${projectpath}"
//                 }
//             }
//         }

//         stage('Package') {
//             when {
//                 allOf {
//                     expression { params.CHOICES == 'package' }
//                     not {
//                         branch 'feature/temp'
//                     }
//                 }
//             }
//             steps {
//                 zip zipFile: 'published.zip',
//                     archive: true,
//                     dir: './published',
//                     overwrite: true
//             }
//         }
//     }
// }
// 🔍 Explanation of Logic:
// Stage	Condition Type	Logic
// Build	allOf	Only runs if on develop branch and choice is build or package
// Package	allOf + not	Only runs if choice is package and NOT on feature/temp branch
// 💡 Bonus Tips:
// You can nest not, allOf, and anyOf as deep as needed.

// Use input step with parameters to make it interactive.

// Combine with environment for more dynamic conditions.

// Let me know if you want me to add dynamic email notifications, test stage gates, or Slack integrations into this pipeline – happy to trick it out 🚀

// You said:
// where can I set beforeagent,beforeinput,beforeoptions in whencondition
// ChatGPT said:
// Excellent curiosity, Akhil! 🔥 You're diving into the deep cuts of Jenkins declarative pipeline syntax. Let's unpack this one carefully:

// 🧠 What Are beforeAgent, beforeInput, and beforeOptions?
// These are boolean flags you can use inside a when condition to control when that condition is evaluated during pipeline execution.

// They don’t define new logic — they control when the condition block gets executed relative to the stage's other directives like agent, input, and options.

// 📌 Why Use Them?
// Let’s say your when condition references a parameter or an environment variable — you may want that logic to be evaluated:

// Before the agent is allocated (to avoid wasting executor time)

// Before user input is requested

// Before the stage options are evaluated (like timeout)

// 🔧 Where Do You Set Them?
// These flags go inside the when block, alongside the logical conditions, not inside them. Like this:

// stage('My Stage') {
//     when {
//         beforeAgent true
//         expression { return params.RUN_STAGE == 'yes' }
//     }
//     agent { label 'linux' }
//     steps {
//         echo 'Running stage!'
//     }
// }
// 🪜 Summary of the Flags:
// Flag	Description
// beforeAgent	Evaluate when before agent allocation (default: false)
// beforeInput	Evaluate before input prompt (default: false)
// beforeOptions	Evaluate before options {} block (default: false)
// ✅ Practical Example in Your Pipeline
// Let’s enhance your Build stage with beforeAgent to prevent node allocation if the condition fails:

// stage('Build') {
//     when {
//         beforeAgent true
//         allOf {
//             branch 'develop'
//             expression { params.CHOICES == 'build' || params.CHOICES == 'package' }
//         }
//     }
//     agent {
//         node {
//             label 'dotnet'
//         }
//     }
//     tools {
//         dotnetsdk 'DOTNET_HOME'
//     }
//     steps {
//         script {
//             def projectpath = sh(script: "find . -name Nop.Web.csproj", returnStdout: true).trim()
//             dotnetPublish configuration: 'Release', outputDirectory: 'published', project: "${projectpath}"
//         }
//     }
// }
// 💥 Pro Tip:
// Use beforeAgent true as a performance optimization in pipelines that run often or use expensive/limited agents — it prevents unnecessary executor allocation.

// Let me know if you want a visual diagram of how the when block interacts with pipeline execution order — or want to see beforeInput in action with an input step! 🧩




// No file chosenNo file chosen
// ChatGPT can make mistakes. Check important info.
// ch
