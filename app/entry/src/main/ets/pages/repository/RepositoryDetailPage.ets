import { AppRoute } from '../../navigation/AppRoute';
import { IssueCommentModel } from '../../model/IssueCommentModel';
import { IssueModel } from '../../model/IssueModel';
import { RepositoryFileModel } from '../../model/RepositoryFileModel';
import { RepositoryModel } from '../../model/RepositoryModel';
import { AtomGitIssueService } from '../../service/AtomGitIssueService';
import { AtomGitRepositoryService } from '../../service/AtomGitRepositoryService';
import { RepositoryStore } from '../../store/RepositoryStore';
import { RepositoryFilesSection } from './RepositoryFilesSection';
import { RepositoryIssueReplyNotice } from './RepositoryIssueReplyNotice';
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

  handleOpenDirectory(path: string): void {
    this.loadFiles(path);
  }

  handleOpenFile(path: string): void {
    this.loadFileContent(path);
  }

  handleGoParentPath(): void {
    this.goParentPath();
  }

  handleOpenIssue(issue: IssueModel): void {
    this.loadIssueDetail(issue);
  }

  setRepositoryLoading(isLoading: boolean): void {
    this.isLoading = isLoading;
  }

  setReadmeLoading(isLoading: boolean): void {
    this.isReadmeLoading = isLoading;
  }

  setFilesLoading(isLoading: boolean): void {
    this.isFilesLoading = isLoading;
  }

  setFileContentLoading(isLoading: boolean): void {
    this.isFileContentLoading = isLoading;
  }

  setIssuesLoading(isLoading: boolean): void {
    this.isIssuesLoading = isLoading;
  }

  setIssueDetailLoading(isLoading: boolean): void {
    this.isIssueDetailLoading = isLoading;
  }

  setIssueCommentsLoading(isLoading: boolean): void {
    this.isIssueCommentsLoading = isLoading;
  }

  setRepositoryMessage(message: string): void {
    this.errorMessage = message;
  }

  setReadmeMessage(message: string): void {
    this.readmeMessage = message;
  }

  setFilesMessage(message: string): void {
    this.filesMessage = message;
  }

  setFileContentMessage(message: string): void {
    this.fileContentMessage = message;
  }

  setIssuesMessage(message: string): void {
    this.issuesMessage = message;
  }

  setIssueDetailMessage(message: string): void {
    this.issueDetailMessage = message;
  }

  setIssueCommentsMessage(message: string): void {
    this.issueCommentsMessage = message;
  }

  resetReadmeContent(): void {
    this.readmeContent = '';
  }

  resetFilePreview(): void {
    this.selectedFilePath = '';
    this.fileContent = '';
    this.setFileContentMessage('');
  }

  resetIssueComments(): void {
    this.issueComments = [];
    this.setIssueCommentsMessage('');
  }

  truncateContent(content: string, maxLength: number): string {
    if (content.length <= maxLength) {
      return content;
    }

    return content.substring(0, maxLength) + '\n...';
  }

  truncateReadmeContent(content: string): string {
    return this.truncateContent(content, 1200);
  }

  truncateFileContent(content: string): string {
    return this.truncateContent(content, 1600);
  }

  @Builder
  buildSummarySection() {
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
  }

  @Builder
  buildFilesSection() {
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
        this.handleOpenDirectory(path);
      },
      onOpenFile: (path: string) => {
        this.handleOpenFile(path);
      },
      onUp: () => {
        this.handleGoParentPath();
      }
    })
  }

  @Builder
  buildReadmeSection() {
    RepositoryReadmeSection({
      isReadmeLoading: this.isReadmeLoading,
      readmeMessage: this.readmeMessage,
      readmeContent: this.readmeContent
    })
  }

  @Builder
  buildIssuesSection() {
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
        this.handleOpenIssue(issue);
      }
    })
  }

  async loadRepositoryDetail(): Promise<void> {
    if (this.repository === null) {
      this.setRepositoryMessage('No repository selected');
      return;
    }

    this.setRepositoryLoading(true);
    const detail = await AtomGitRepositoryService.getRepositoryDetail(this.repository);
    this.setRepositoryLoading(false);

    if (detail === null) {
      this.setRepositoryMessage('Repository detail load failed');
    } else {
      this.repository = detail;
      RepositoryStore.setSelectedRepository(detail);
      this.setRepositoryMessage('');
    }

    await this.loadFiles('');
    await this.loadReadme();
    await this.loadIssues();
  }

  async loadReadme(): Promise<void> {
    if (this.repository === null) {
      return;
    }

    this.setReadmeLoading(true);
    const content = await AtomGitRepositoryService.getReadme(this.repository);
    this.setReadmeLoading(false);

    if (content.length === 0) {
      this.setReadmeMessage('README not found');
      this.resetReadmeContent();
      return;
    }

    this.readmeContent = this.truncateReadmeContent(content);
    this.setReadmeMessage('');
  }

  async loadIssues(): Promise<void> {
    if (this.repository === null) {
      return;
    }

    this.setIssuesLoading(true);
    const result = await AtomGitIssueService.getOpenIssues(this.repository);
    this.setIssuesLoading(false);
    this.issues = result;

    if (result.length === 0) {
      this.setIssuesMessage('No open issues found');
    } else {
      this.setIssuesMessage('');
    }
  }

  async loadIssueDetail(issue: IssueModel): Promise<void> {
    if (this.repository === null) {
      return;
    }

    this.selectedIssue = issue;
    this.setIssueDetailMessage('');
    this.resetIssueComments();
    this.setIssueDetailLoading(true);
    const detail = await AtomGitIssueService.getIssueDetail(this.repository, issue.number);
    this.setIssueDetailLoading(false);

    if (detail === null) {
      this.setIssueDetailMessage('Issue detail load failed');
      return;
    }

    this.selectedIssue = detail;
    await this.loadIssueComments(detail.number);
  }

  async loadIssueComments(issueNumber: number): Promise<void> {
    if (this.repository === null) {
      return;
    }

    this.setIssueCommentsLoading(true);
    const result = await AtomGitIssueService.getIssueComments(this.repository, issueNumber);
    this.setIssueCommentsLoading(false);
    this.issueComments = result;

    if (result.length === 0) {
      this.setIssueCommentsMessage('No comments found');
    } else {
      this.setIssueCommentsMessage('');
    }
  }

  async loadFiles(targetPath: string): Promise<void> {
    if (this.repository === null) {
      return;
    }

    this.setFilesLoading(true);
    this.currentPath = targetPath;
    this.resetFilePreview();
    const result = await AtomGitRepositoryService.getFiles(this.repository, targetPath);
    this.setFilesLoading(false);
    this.files = result;

    if (result.length === 0) {
      this.setFilesMessage('No files found');
    } else {
      this.setFilesMessage('');
    }
  }

  async loadFileContent(filePath: string): Promise<void> {
    if (this.repository === null) {
      return;
    }

    this.selectedFilePath = filePath;
    this.fileContent = '';
    this.setFileContentMessage('');
    this.setFileContentLoading(true);
    const content = await AtomGitRepositoryService.getFileContent(this.repository, filePath);
    this.setFileContentLoading(false);

    if (content.length === 0) {
      this.setFileContentMessage('File content not available');
      return;
    }

    this.fileContent = this.truncateFileContent(content);
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

        this.buildSummarySection()
        this.buildFilesSection()
        this.buildReadmeSection()
        this.buildIssuesSection()

        RepositoryIssueReplyNotice()
      }
      .width('100%')
      .padding(20)
    }
    .width('100%')
    .height('100%')
  }
}
