# pj-eks
This project introduces the method for deploying a database and application on AWS EKS.

# Hint
Here are some recommendations to help you deploy the code in this repository:<br>
1. Ensure the Docker image platform is compatible with the EKS node group platform.
2. If the application's readiness check fails, verify that the table "tokens" exists in the database.

# Deployment Instruction
1. **Set Up AWS EKS and Node Group**
   - Create an AWS EKS cluster and configure a node group.
   - Ensure the node group uses the correct image type.
   - connect kubectl to the EKS using :
     ```bash
        aws eks --region us-east-1 update-kubeconfig --name <cluster name>
        kubectl config current-context
     ```

2. **Create a CodeBuild Project**
   - Create a CodeBuild project and connect it to the GitHub repository containing the application code.

3. **Configure CodeBuild Triggers**
   - Set up CodeBuild to trigger on specific GitHub events, such as a code push or pull request.

4. **Configure CodeBuild to Build and Push Docker Images**
   - Use a buildspec.yml file to build the Docker image and push it to the Amazon ECR repository.

5. **Deploy PersistentVolumeClaim (PVC) and PersistentVolume (PV)**
   - Run the following commands to apply the PVC and PV configuration files:
     ```bash
     kubectl apply -f ./deployment/pvc.yaml
     kubectl apply -f ./deployment/pv.yaml
     ```

6. **Deploy PostgreSQL**
   - Deploy the PostgreSQL resources using the following commands:
     ```bash
     kubectl apply -f ./deployment/postgressql-deployment.yaml
     kubectl apply -f ./deployment/postgressql-service.yaml
     ```

7. **Execute SQL Scripts in the PostgreSQL Pod**
   - Once the PostgreSQL Pod is ready, connect to it and execute the SQL scripts located in the db folder.

8. **Deploy ConfigMap**
   - Apply the ConfigMap configuration using the following command:
     ```bash
     kubectl apply -f ./deployment/configmap.yaml
     ```

9. **Deploy the Coworking Application**
   - Deploy the application by running:
     ```bash
     kubectl apply -f ./deployment/coworking.yaml
     ```
     
# Project Structure
pj-eks/
├── analytics/
│   ├── init.py                         # Initializes the application and sets up configurations
│   ├── app.py                          # Main application 
│   ├── config.py                       # Configuration settings for the application
│   ├── requirements.txt                # Lists dependencies required for the application
├── db/
│   ├── 1_create_tables.sql             # SQL script for creating database tables
│   ├── 2_seed_users.sql                # SQL script for seeding the "users" table with initial data
│   ├── 3_seed_tokens.sql               # SQL script for seeding the "tokens" table with initial data
├── deployment/
│   ├── configmap.yaml                  # Kubernetes ConfigMap definition for storing configuration data
│   ├── coworking.yaml                  # Kubernetes deployment for the application
│   ├── postgresql-deployment.yaml      # Kubernetes deployment for the  database
│   ├── postgresql-service.yaml         # Kubernetes Service definition for PostgreSQL access
│   ├── pv.yaml                         # Persistent Volume definition for database storage
│   ├── pvc.yaml                        # Persistent Volume Claim definition for database storage
├── README.md                           # Instructions for the project
├── Dockerfile                          # Dockerfile to containerize the application
├── buildspec.yml                       # Build specification for AWS CodeBuild
├── LICENSE.txt                         
├── CODEOWNERS                          
