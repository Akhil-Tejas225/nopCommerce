pipeline {
    options {
        timeout(time: 1, unit: 'HOURS') 
    }
    triggers {
        cron('H */4 * * 1-5')
    }
    parameter {
        choice(name: GOALS, choices: ['publish','build','test'], descrption: 'This is dotnet build life cycle' )
    }
    stages{
        stage('git'){
            steps {
                git url: 
            }
        }
    }
}  
