# ReplicaSet = maintains a number of pods with goal of minimum constant pods
# Job = spins up pods with goal of completing a task

# YAML sample for JOB
apiVersion: batch/v1
kind: Job
metadata:
    name: math-add-Job
spec:
    completions: 3      # Job keeps running until we have 3 successful attempts
    parallelism: 3      # Job runs 3 pods in parallel 
    template:
        spec:
            containers: 
            - name: math-add
              image: ubunutu
              command: ['expr', '1', '+', '2']
            restartPolicy = Never   #important to specify since it's just a job

# to look at the output of the job:
k logs <pod-name>

# YAML sample for CRONJOB
apiVersion: batch/v1
kind: CronJob 
metadata:
    name: reporting-cronjob 
spec: # WARNING! THERE ARE THREE SPECS WITH CRONJOBS
    schedule: "0 0 1 * *" # Run once a month at midnight of the 1st day of the month
    jobTemplate: 
        spec:
        completions: 3      # Job keeps running until we have 3 successful attempts
        parallelism: 3      # Job runs 3 pods in parallel 
        template:
            spec:
                containers: 
                - name: math-add
                image: ubunutu
                command: ['expr', '1', '+', '2']
                restartPolicy = Never   #important to specify since it's just a job

# ┌───────────── minute (0 - 59)
# │ ┌───────────── hour (0 - 23)
# │ │ ┌───────────── day of the month (1 - 31)
# │ │ │ ┌───────────── month (1 - 12)
# │ │ │ │ ┌───────────── day of the week (0 - 6) (Sunday to Saturday;
# │ │ │ │ │                                   7 is also Sunday on some systems)
# │ │ │ │ │                                   OR sun, mon, tue, wed, thu, fri, sat
# │ │ │ │ │
# * * * * *
        
