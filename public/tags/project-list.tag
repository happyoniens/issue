<project-list>
    <h2 class="mt-3" >Project List</h2>

    <error if="{loading_failed}" message="Failed to load projects, check your internet connection" />
    <loading if="{is_loading}"/>
    <div class="list-group-container"> 
        <div class="btn-group-vertical list-group">
            <project onclick="{onProjectClicked}" each="{this.projects}" data="{this}" is-selected="{this.selectedProjectClientId == client_id}" />
        </div>
    </div>
    <script>
        this.projects = [];
        this.selectedProjectClientId = undefined;

        this.is_loading = true;

        ProjectDatabaseService.getProjects()
            .then((projects) => this.projects = projects)
            .catch((err) => {
                this.loading_failed = true;
            })
            .finally(() => {
                this.is_loading = false;
                this.update();
            });

        this.addNewProject = (project) => {
            ProjectDatabaseService.saveProject(project).then(data => {
                this.projects.push(data);
                this.update();
            });
        }

        this.onProjectClicked = (e) => {
            this.selectedProjectClientId = e.item.client_id;
            this.update();
            opts.changeProject(e);
        }
    </script>
</project-list>
