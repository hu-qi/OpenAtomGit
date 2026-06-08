import { AppRoute } from '../../navigation/AppRoute';
import { IssueCommentModel } from '../../model/IssueCommentModel';
import { IssueModel } from '../../model/IssueModel';
import { RepositoryFileModel } from '../../model/RepositoryFileModel';
import { RepositoryModel } from '../../model/RepositoryModel';
import { AtomGitIssueService } from '../../service/AtomGitIssueService';
import { AtomGitRepositoryService } from '../../service/AtomGitRepositoryService';
import { RepositoryStore } from '../../store/RepositoryStore';
import { RepositoryFilesSection } from './RepositoryFilesSection';
import { RepositoryIssuesSection } from './RepositoryIssuesSection';
import { RepositoryReadmeSection } from './RepositoryReadmeSection';
import { RepositorySummarySection } from './RepositorySummarySection';

@Component
export struct RepositoryDetailPage {
  onNavigate: (route: string) => void = () => {};
  @State isLoading: boolean = false;
  @State isReadmeLoading: boolean = false;
  @State isFilesLoading: boolean = false;
  @State isFileContentLoading: boolean = false;
  @State isIssuesLoading: boolean = false;
  @State isIssueDetailLoading: boolean = false;
  @State isIssueCommentsLoading: boolean = false;
  @State errorMessage: string = '';
  @State readmeMessage: string = '';
  @State filesMessage: string = '';
  @State fileContentMessage: string = '';
  @State issuesMessage: string = '';
  @State issueDetailMessage: string = '';
  @State issueCommentsMessage: string = '';
  @State readmeContent: string = '';
  @State currentPath: string = '';
  @State selectedFilePath: string = '';
  @State fileContent: string = '';
  @State files: RepositoryFileModel[] = [];
  @State issues: IssueModel[] = [];
  @State issueComments: IssueCommentModel[] = [];
  @State selectedIssue: IssueModel | null = null;
  @State repository: RepositoryModel | null = RepositoryStore.getSelectedRepository();

  aboutToAppear(): void {
    this.loadRepositoryDetail();
  }

  async loadRepositoryDetail(): Promise<void> {
    if (this.repository === null) {
      this.errorMessage = 'No repository selected';
      return;
    }

    this.isLoading = true;
    const detail = await AtomGitRepositoryService.getRepositoryDetail(this.repository);
    this.isLoading = false;

    if (detail === null) {
      this.errorMessage = 'Repository detail load failed';
    } else {
      this.repository = detail;
      RepositoryStore.setSelectedRepository(detail);
      this.errorMessage = '';
    }

    await this.loadFiles('');
    await this.loadReadme();
    await this.loadIssues();
  }

  async loadReadme(): Promise<void> {
    if (this.repository === null) {
      return;
    }

    this.isReadmeLoading = true;
    const content = await AtomGitRepositoryService.getReadme(this.repository);
    this.isReadmeLoading = false;

    if (content.length === 0) {
      this.readmeMessage = 'README not found';
      this.readmeContent = '';
      return;
    }

    this.readmeContent = content.length > 1200 ? content.substring(0, 1200) + '\n...' : content;
    this.readmeMessage = '';
  }

  async loadIssues(): Promise<void> {
    if (this.repository === null) {
      return;
    }

    this.isIssuesLoading = true;
    const result = await AtomGitIssueService.getOpenIssues(this.repository);
    this.isIssuesLoading = false;
    this.issues = result;

    if (result.length === 0) {
      this.issuesMessage = 'No open issues found';
    } else {
      this.issuesMessage = '';
    }
  }

  async loadIssueDetail(issue: IssueModel): Promise<void> {
    if (this.repository === null) {
      return;
    }

    this.selectedIssue = issue;
    this.issueDetailMessage = '';
    this.issueComments = [];
    this.issueCommentsMessage = '';
    this.isIssueDetailLoading = true;
    const detail = await AtomGitIssueService.getIssueDetail(this.repository, issue.number);
    this.isIssueDetailLoading = false;

    if (detail === null) {
      this.issueDetailMessage = 'Issue detail load failed';
      return;
    }

    this.selectedIssue = detail;
    await this.loadIssueComments(detail.number);
  }

  async loadIssueComments(issueNumber: number): Promise<void> {
    if (this.repository === null) {
      return;
    }

    this.isIssueCommentsLoading = true;
    const result = await AtomGitIssueService.getIssueComments(this.repository, issueNumber);
    this.isIssueCommentsLoading = false;
    this.issueComments = result;

    if (result.length === 0) {
      this.issueCommentsMessage = 'No comments found';
    } else {
      this.issueCommentsMessage = '';
    }
  }

  async loadFiles(targetPath: string): Promise<void> {
    if (this.repository === null) {
      return;
    }

    this.isFilesLoading = true;
    this.currentPath = targetPath;
    this.selectedFilePath = '';
    this.fileContent = '';
    this.fileContentMessage = '';
    const result = await AtomGitRepositoryService.getFiles(this.repository, targetPath);
    this.isFilesLoading = false;
    this.files = result;

    if (result.length === 0) {
      this.filesMessage = 'No files found';
    } else {
      this.filesMessage = '';
    }
  }

  async loadFileContent(filePath: string): Promise<void> {
    if (this.repository === null) {
      return;
    }

    this.selectedFilePath = filePath;
    this.fileContent = '';
    this.fileContentMessage = '';
    this.isFileContentLoading = true;
    const content = await AtomGitRepositoryService.getFileContent(this.repository, filePath);
    this.isFileContentLoading = false;

    if (content.length === 0) {
      this.fileContentMessage = 'File content not available';
      return;
    }

    this.fileContent = content.length > 1600 ? content.substring(0, 1600) + '\n...' : content;
  }

  async goParentPath(): Promise<void> {
    if (this.currentPath.length === 0) {
      return;
    }

    const index = this.currentPath.lastIndexOf('/');
    const parentPath = index < 0 ? '' : this.currentPath.substring(0, index);
    await this.loadFiles(parentPath);
  }

  build() {
    Scroll() {
      Column() {
        Text('Back')
          .fontSize(18)
          .onClick(() => {
            this.onNavigate(AppRoute.SEARCH)
          })

        RepositorySummarySection({
          fullName: this.repository === null ? '' : this.repository.getFullName(),
          description: this.repository === null ? '' : this.repository.description,
          stars: this.repository === null ? 0 : this.repository.stars,
          forks: this.repository === null ? 0 : this.repository.forks,
          watchers: this.repository === null ? 0 : this.repository.watchers,
          defaultBranch: this.repository === null ? '' : this.repository.defaultBranch,
          isLoading: this.isLoading,
          errorMessage: this.errorMessage
        })

        RepositoryFilesSection({
          currentPath: this.currentPath,
          files: this.files,
          isFilesLoading: this.isFilesLoading,
          filesMessage: this.filesMessage,
          selectedFilePath: this.selectedFilePath,
          isFileContentLoading: this.isFileContentLoading,
          fileContentMessage: this.fileContentMessage,
          fileContent: this.fileContent,
          onOpenDirectory: (path: string) => {
            this.loadFiles(path);
          },
          onOpenFile: (path: string) => {
            this.loadFileContent(path);
          },
          onUp: () => {
            this.goParentPath();
          }
        })

        RepositoryReadmeSection({
          isReadmeLoading: this.isReadmeLoading,
          readmeMessage: this.readmeMessage,
          readmeContent: this.readmeContent
        })

        RepositoryIssuesSection({
          issues: this.issues,
          selectedIssue: this.selectedIssue,
          issueComments: this.issueComments,
          isIssuesLoading: this.isIssuesLoading,
          isIssueDetailLoading: this.isIssueDetailLoading,
          isIssueCommentsLoading: this.isIssueCommentsLoading,
          issuesMessage: this.issuesMessage,
          issueDetailMessage: this.issueDetailMessage,
          issueCommentsMessage: this.issueCommentsMessage,
          onOpenIssue: (issue: IssueModel) => {
            this.loadIssueDetail(issue);
          }
        })

        Text('Issue comments reply 将在后续版本接入。')
          .fontSize(14)
          .margin({ top: 24, bottom: 24 })
      }
      .width('100%')
      .padding(20)
    }
    .width('100%')
    .height('100%')
  }
}
