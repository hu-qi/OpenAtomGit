import { AppRoute } from '../../navigation/AppRoute';
import { IssueCommentModel } from '../../model/IssueCommentModel';
import { IssueModel } from '../../model/IssueModel';
import { RepositoryFileModel } from '../../model/RepositoryFileModel';
import { RepositoryModel } from '../../model/RepositoryModel';
import { AtomGitIssueService } from '../../service/AtomGitIssueService';
import { AtomGitRepositoryService } from '../../service/AtomGitRepositoryService';
import { RepositoryStore } from '../../store/RepositoryStore';

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

  async aboutToAppear(): Promise<void> {
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

        Text('Repository Detail')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 24 })

        if (this.isLoading) {
          Text('Loading repository detail...')
            .fontSize(15)
            .margin({ top: 16 })
        }

        if (this.errorMessage.length > 0) {
          Text(this.errorMessage)
            .fontSize(14)
            .fontColor('#E5484D')
            .margin({ top: 12 })
        }

        Text(this.repository === null ? 'No repository selected' : this.repository.getFullName())
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 16 })

        Text(this.repository === null ? '' : (this.repository.description.length > 0 ? this.repository.description : 'No description'))
          .fontSize(15)
          .lineHeight(24)
          .margin({ top: 12 })

        Row() {
          this.MetricItem('Stars', this.repository === null ? 0 : this.repository.stars)
          this.MetricItem('Forks', this.repository === null ? 0 : this.repository.forks)
          this.MetricItem('Watchers', this.repository === null ? 0 : this.repository.watchers)
        }
        .width('100%')
        .margin({ top: 20 })

        Text(this.repository === null || this.repository.defaultBranch.length === 0 ? 'Default branch: -' : 'Default branch: ' + this.repository.defaultBranch)
          .fontSize(14)
          .margin({ top: 16 })

        Text('Files')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 28 })

        Row() {
          Text(this.currentPath.length === 0 ? 'Path: /' : 'Path: /' + this.currentPath)
            .fontSize(13)
            .layoutWeight(1)

          if (this.currentPath.length > 0) {
            Text('Up')
              .fontSize(13)
              .fontWeight(FontWeight.Bold)
              .onClick(async () => {
                await this.goParentPath();
              })
          }
        }
        .width('100%')
        .margin({ top: 8 })

        if (this.isFilesLoading) {
          Text('Loading files...')
            .fontSize(15)
            .margin({ top: 12 })
        }

        if (this.filesMessage.length > 0) {
          Text(this.filesMessage)
            .fontSize(14)
            .fontColor('#6B7280')
            .margin({ top: 12 })
        }

        ForEach(this.files, (item: RepositoryFileModel) => {
          Row() {
            Text(item.isDirectory() ? 'DIR' : 'FILE')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .width(44)

            Column() {
              Text(item.name)
                .fontSize(15)
                .fontWeight(FontWeight.Bold)
              Text(item.path)
                .fontSize(12)
                .margin({ top: 4 })
            }
            .layoutWeight(1)

            Text(item.isDirectory() ? 'Open' : 'Preview')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
          }
          .width('100%')
          .padding(12)
          .margin({ top: 8 })
          .backgroundColor(Color.White)
          .borderRadius(12)
          .onClick(async () => {
            if (item.isDirectory()) {
              await this.loadFiles(item.path);
            } else {
              await this.loadFileContent(item.path);
            }
          })
        }, (item: RepositoryFileModel) => item.path)

        if (this.selectedFilePath.length > 0) {
          Text('File Preview')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 28 })

          Text(this.selectedFilePath)
            .fontSize(13)
            .margin({ top: 8 })

          if (this.isFileContentLoading) {
            Text('Loading file content...')
              .fontSize(15)
              .margin({ top: 12 })
          }

          if (this.fileContentMessage.length > 0) {
            Text(this.fileContentMessage)
              .fontSize(14)
              .fontColor('#6B7280')
              .margin({ top: 12 })
          }

          if (this.fileContent.length > 0) {
            Text(this.fileContent)
              .fontSize(12)
              .lineHeight(18)
              .padding(12)
              .margin({ top: 12 })
              .backgroundColor(Color.White)
              .borderRadius(12)
          }
        }

        Text('README')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 28 })

        if (this.isReadmeLoading) {
          Text('Loading README...')
            .fontSize(15)
            .margin({ top: 12 })
        }

        if (this.readmeMessage.length > 0) {
          Text(this.readmeMessage)
            .fontSize(14)
            .fontColor('#6B7280')
            .margin({ top: 12 })
        }

        if (this.readmeContent.length > 0) {
          Text(this.readmeContent)
            .fontSize(13)
            .lineHeight(20)
            .padding(12)
            .margin({ top: 12 })
            .backgroundColor(Color.White)
            .borderRadius(12)
        }

        Text('Issues')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 28 })

        if (this.isIssuesLoading) {
          Text('Loading issues...')
            .fontSize(15)
            .margin({ top: 12 })
        }

        if (this.issuesMessage.length > 0) {
          Text(this.issuesMessage)
            .fontSize(14)
            .fontColor('#6B7280')
            .margin({ top: 12 })
        }

        ForEach(this.issues, (item: IssueModel) => {
          Column() {
            Text('#' + item.number.toString() + ' ' + item.title)
              .fontSize(15)
              .fontWeight(FontWeight.Bold)
            Text(item.state + (item.author.length > 0 ? ' · ' + item.author : '') + ' · Tap to view detail')
              .fontSize(12)
              .margin({ top: 6 })
          }
          .width('100%')
          .padding(12)
          .margin({ top: 8 })
          .backgroundColor(Color.White)
          .borderRadius(12)
          .onClick(async () => {
            await this.loadIssueDetail(item);
          })
        }, (item: IssueModel) => item.number.toString())

        if (this.selectedIssue !== null) {
          Text('Issue Detail')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 28 })

          if (this.isIssueDetailLoading) {
            Text('Loading issue detail...')
              .fontSize(15)
              .margin({ top: 12 })
          }

          if (this.issueDetailMessage.length > 0) {
            Text(this.issueDetailMessage)
              .fontSize(14)
              .fontColor('#6B7280')
              .margin({ top: 12 })
          }

          Text('#' + this.selectedIssue.number.toString() + ' ' + this.selectedIssue.title)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 12 })

          Text(this.selectedIssue.state + ' · comments ' + this.selectedIssue.comments.toString())
            .fontSize(13)
            .margin({ top: 8 })

          Text(this.selectedIssue.updatedAt.length > 0 ? 'Updated: ' + this.selectedIssue.updatedAt : '')
            .fontSize(12)
            .margin({ top: 6 })

          Text(this.selectedIssue.body.length > 0 ? this.selectedIssue.body : 'No issue body')
            .fontSize(13)
            .lineHeight(20)
            .padding(12)
            .margin({ top: 12 })
            .backgroundColor(Color.White)
            .borderRadius(12)

          Text('Comments')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 20 })

          if (this.isIssueCommentsLoading) {
            Text('Loading issue comments...')
              .fontSize(15)
              .margin({ top: 12 })
          }

          if (this.issueCommentsMessage.length > 0) {
            Text(this.issueCommentsMessage)
              .fontSize(14)
              .fontColor('#6B7280')
              .margin({ top: 12 })
          }

          ForEach(this.issueComments, (item: IssueCommentModel) => {
            Column() {
              Text(item.author.length > 0 ? item.author : 'Unknown')
                .fontSize(14)
                .fontWeight(FontWeight.Bold)
              Text(item.updatedAt.length > 0 ? 'Updated: ' + item.updatedAt : '')
                .fontSize(12)
                .margin({ top: 4 })
              Text(item.body.length > 0 ? item.body : 'No comment body')
                .fontSize(13)
                .lineHeight(20)
                .margin({ top: 8 })
            }
            .width('100%')
            .padding(12)
            .margin({ top: 8 })
            .backgroundColor(Color.White)
            .borderRadius(12)
          }, (item: IssueCommentModel) => item.id.toString())
        }

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

  @Builder
  MetricItem(label: string, value: number) {
    Column() {
      Text(value.toString())
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
      Text(label)
        .fontSize(12)
        .margin({ top: 4 })
    }
    .layoutWeight(1)
    .padding(12)
    .backgroundColor(Color.White)
    .borderRadius(12)
  }
}
