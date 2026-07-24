import Foundation

struct TendiLocalUser: Decodable {
    let id: String
    let nickname: String
    let avatarImageName: String
    let isTestUser: Bool
    let bio: String
    let birthdayRawValue: String
    let followerCount: Int
    let followingCount: Int
    let coinBalance: Int

    init(
        id: String,
        nickname: String,
        avatarImageName: String,
        isTestUser: Bool,
        bio: String,
        birthdayRawValue: String,
        followerCount: Int,
        followingCount: Int,
        coinBalance: Int
    ) {
        self.id = id
        self.nickname = nickname
        self.avatarImageName = avatarImageName
        self.isTestUser = isTestUser
        self.bio = bio
        self.birthdayRawValue = birthdayRawValue
        self.followerCount = followerCount
        self.followingCount = followingCount
        self.coinBalance = coinBalance
    }

    private enum CodingKeys: String, CodingKey {
        case id = "xL4c"
        case nickname = "mJ4q"
        case avatarImageName = "aV9k"
        case isTestUser = "nQ6z"
        case bio = "bT5w"
        case birthdayRawValue = "yK3f"
        case followerCount = "fC8n"
        case followingCount = "pX2d"
        case coinBalance = "sE9a"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        nickname = try container.decodeIfPresent(String.self, forKey: .nickname) ?? "Tendi user"
        avatarImageName = try container.decodeIfPresent(String.self, forKey: .avatarImageName) ?? "tendi_avatar"
        isTestUser = try container.decodeIfPresent(Bool.self, forKey: .isTestUser) ?? false
        bio = try container.decodeIfPresent(String.self, forKey: .bio) ?? ""
        birthdayRawValue = try container.decodeIfPresent(String.self, forKey: .birthdayRawValue) ?? ""
        followerCount = try container.decodeIfPresent(Int.self, forKey: .followerCount) ?? 0
        followingCount = try container.decodeIfPresent(Int.self, forKey: .followingCount) ?? 0
        coinBalance = try container.decodeIfPresent(Int.self, forKey: .coinBalance) ?? 0
    }

    func updating(nickname: String, bio: String, birthdayRawValue: String) -> TendiLocalUser {
        TendiLocalUser(
            id: id,
            nickname: nickname,
            avatarImageName: avatarImageName,
            isTestUser: isTestUser,
            bio: bio,
            birthdayRawValue: birthdayRawValue,
            followerCount: followerCount,
            followingCount: followingCount,
            coinBalance: coinBalance
        )
    }
}

private struct TendiLocalProfileOverride: Codable {
    let nickname: String
    let bio: String
    let birthdayRawValue: String
}

struct TendiLocalPost: Decodable {
    let id: String
    let type: String
    let userId: String
    let likedUserIds: [String]
    let commentsCount: Int
    let content: String
    let imageNames: [String]
    let videoCoverImageName: String
    let videoFileName: String

    private enum CodingKeys: String, CodingKey {
        case id = "xL4c"
        case type = "vS7d"
        case userId = "uF2m"
        case likedUserIds = "aQ5p"
        case commentsCount = "cF9y"
        case content = "rM2h"
        case imageNames = "nL3e"
        case videoCoverImageName = "bX8r"
        case videoFileName = "tW4z"
    }

    var likeCount: Int { likedUserIds.count }
}

struct TendiLocalFollow: Decodable {
    let userId: String
    let targetUserId: String

    private enum CodingKeys: String, CodingKey {
        case userId = "uF2m"
        case targetUserId = "tA7e"
    }
}

struct TendiLocalComment: Codable {
    let id: String
    let postId: String
    let userId: String
    let content: String
    let createdAt: String?

    private enum CodingKeys: String, CodingKey {
        case id = "xL4c"
        case postId = "jP6c"
        case userId = "uF2m"
        case content = "rM2h"
        case createdAt = "dR8p"
    }
}

struct TendiHomeVideoItem {
    let post: TendiLocalPost
    let user: TendiLocalUser
    let comments: [TendiLocalComment]
    let isLikedByCurrentUser: Bool

    var id: String { post.id }
    var nickname: String { user.nickname }
    var avatarImageName: String { user.avatarImageName }
    var content: String { post.content }
    var coverImageName: String { post.videoCoverImageName }
    var videoFileName: String { post.videoFileName }
    var likeCount: Int { post.likeCount }
    var commentCount: Int { comments.count }
    var videoURL: URL? {
        TendiLocalDataStore.bundleURL(forFileName: videoFileName, subdirectory: "Video")
    }
}

struct TendiFindPostItem {
    let post: TendiLocalPost
    let user: TendiLocalUser
    let comments: [TendiLocalComment]
    let isLikedByCurrentUser: Bool

    var id: String { post.id }
    var nickname: String { user.nickname }
    var avatarImageName: String { user.avatarImageName }
    var content: String { post.content }
    var imageName: String { post.imageNames.first ?? "cell_bg" }
    var likeCount: Int { post.likeCount }
    var commentCount: Int { comments.count }
}

enum TendiUserPostItem {
    case video(TendiHomeVideoItem)
    case image(TendiFindPostItem)

    var user: TendiLocalUser {
        switch self {
        case .video(let item):
            return item.user
        case .image(let item):
            return item.user
        }
    }

    var thumbnailImageName: String {
        switch self {
        case .video(let item):
            return item.coverImageName
        case .image(let item):
            return item.imageName
        }
    }
}

struct TendiPostLikeState {
    let count: Int
    let isLiked: Bool
}

struct TendiUserFollowState {
    let isFollowed: Bool
    let canFollow: Bool
    let followerCount: Int
}

struct TendiPostCommentItem {
    let comment: TendiLocalComment
    let user: TendiLocalUser?

    var id: String { comment.id }
    var nickname: String { user?.nickname ?? "Tendi user" }
    var avatarImageName: String { user?.avatarImageName ?? "tendi_avatar" }
    var content: String { comment.content }
}

struct TendiLocalChatMessage: Codable {
    let id: String
    let peerUserId: String
    let senderUserId: String
    let content: String
    let createdAt: String

    private enum CodingKeys: String, CodingKey {
        case id = "xL4c"
        case peerUserId = "pR6u"
        case senderUserId = "sD2e"
        case content = "rM2h"
        case createdAt = "dR8p"
    }
}

struct TendiLocalAiChatMessage: Codable {
    let id: String
    let content: String
    let isOutgoing: Bool
    let createdAt: String

    private enum CodingKeys: String, CodingKey {
        case id = "xL4c"
        case content = "rM2h"
        case isOutgoing = "oG7n"
        case createdAt = "dR8p"
    }
}

struct TendiChatMessageItem {
    let message: TendiLocalChatMessage
    let sender: TendiLocalUser?
    let isOutgoing: Bool

    var id: String { message.id }
    var content: String { message.content }
    var avatarImageName: String { sender?.avatarImageName ?? "tendi_avatar" }
}

struct TendiAiChatMessageItem {
    let message: TendiLocalAiChatMessage
    let avatarImageName: String

    var id: String { message.id }
    var content: String { message.content }
    var isOutgoing: Bool { message.isOutgoing }
}

struct TendiChatPreviewItem {
    let user: TendiLocalUser
    let lastMessage: TendiLocalChatMessage?

    var title: String { user.nickname }
    var avatarImageName: String { user.avatarImageName }
    var previewText: String {
        lastMessage?.content ?? "Say hi to \(user.nickname)"
    }
}

final class TendiLocalDataStore {
    static let shared = TendiLocalDataStore()
    static let aiFeatureUseCost = 200

    var videoItems: [TendiHomeVideoItem] {
        allVideoItems.filter { isBlocked($0.user) == false }
    }

    var imageItems: [TendiFindPostItem] {
        allImageItems.filter { isBlocked($0.user) == false }
    }

    var userPostItems: [TendiUserPostItem] {
        allUserPostItems.filter { isBlocked($0.user) == false }
    }

    var blockedUsers: [TendiLocalUser] {
        sortedUsers(for: blockedUserIds, includesBlockedUsers: true)
    }

    var currentUserProfile: TendiLocalUser? {
        guard let currentUser else { return nil }
        guard let currentProfileOverride else { return currentUser }

        return currentUser.updating(
            nickname: currentProfileOverride.nickname,
            bio: currentProfileOverride.bio,
            birthdayRawValue: currentProfileOverride.birthdayRawValue
        )
    }

    var currentCoinBalance: Int {
        currentCoinBalanceValue
    }

    var currentFollowingUsers: [TendiLocalUser] {
        sortedUsers(for: followedUserIds)
    }

    var currentFollowerUsers: [TendiLocalUser] {
        sortedUsers(for: initialFollowerUserIds)
    }

    private let allVideoItems: [TendiHomeVideoItem]
    private let allImageItems: [TendiFindPostItem]
    private let allUserPostItems: [TendiUserPostItem]
    private let currentUser: TendiLocalUser?
    private let usersById: [String: TendiLocalUser]
    private let initialLikedPostIds: Set<String>
    private let initialFollowedUserIds: Set<String>
    private let initialFollowerUserIds: Set<String>
    private var likedPostIds: Set<String>
    private var followedUserIds: Set<String>
    private var blockedUserIds: Set<String>
    private var localComments: [TendiLocalComment]
    private var localChatMessages: [TendiLocalChatMessage]
    private var localAiChatMessages: [TendiLocalAiChatMessage]
    private var currentCoinBalanceValue: Int
    private var currentProfileOverride: TendiLocalProfileOverride?

    private static let likedPostIdsKey = "TendiLocalDataStore.likedPostIds"
    private static let followedUserIdsKey = "TendiLocalDataStore.followedUserIds"
    private static let blockedUserIdsKey = "TendiLocalDataStore.blockedUserIds"
    private static let localCommentsKey = "TendiLocalDataStore.localComments"
    private static let localChatMessagesKey = "TendiLocalDataStore.localChatMessages"
    private static let localAiChatMessagesKey = "TendiLocalDataStore.localAiChatMessages"
    private static let currentCoinBalanceKeyPrefix = "TendiLocalDataStore.currentCoinBalance"
    private static let currentProfileOverrideKeyPrefix = "TendiLocalDataStore.currentProfileOverride"

    private init() {
        let loadedPayload = TendiLocalDataStore.loadPayload()
        let resolvedCurrentUserId = loadedPayload.users.first(where: { $0.isTestUser })?.id ?? loadedPayload.users.first?.id

        let resolvedUsersById = Dictionary(uniqueKeysWithValues: loadedPayload.users.map { ($0.id, $0) })
        usersById = resolvedUsersById
        let resolvedCurrentUser: TendiLocalUser?
        if let currentUserId = resolvedCurrentUserId {
            resolvedCurrentUser = resolvedUsersById[currentUserId]
        } else {
            resolvedCurrentUser = nil
        }
        currentUser = resolvedCurrentUser

        let follows = loadedPayload.follows
        let comments = loadedPayload.comments

        var resolvedVideoItems: [TendiHomeVideoItem] = []
        var resolvedImageItems: [TendiFindPostItem] = []
        var resolvedUserPostItems: [TendiUserPostItem] = []
        var resolvedInitialLikedPostIds: Set<String> = []

        for post in loadedPayload.posts {
            guard let user = resolvedUsersById[post.userId] else { continue }

            let postComments = comments.filter { comment in
                comment.postId == post.id
            }

            var isLikedByCurrentUser = false
            if let currentUserId = resolvedCurrentUserId {
                isLikedByCurrentUser = post.likedUserIds.contains(currentUserId)
            }

            if isLikedByCurrentUser {
                resolvedInitialLikedPostIds.insert(post.id)
            }

            if post.type == "video" {
                let videoItem = TendiHomeVideoItem(
                    post: post,
                    user: user,
                    comments: postComments,
                    isLikedByCurrentUser: isLikedByCurrentUser
                )
                resolvedVideoItems.append(videoItem)
                resolvedUserPostItems.append(.video(videoItem))
            } else if post.type == "image" {
                let imageItem = TendiFindPostItem(
                    post: post,
                    user: user,
                    comments: postComments,
                    isLikedByCurrentUser: isLikedByCurrentUser
                )
                resolvedImageItems.append(imageItem)
                resolvedUserPostItems.append(.image(imageItem))
            }
        }
        allVideoItems = resolvedVideoItems
        allImageItems = resolvedImageItems
        allUserPostItems = resolvedUserPostItems
        initialLikedPostIds = resolvedInitialLikedPostIds

        var resolvedInitialFollowedUserIds: Set<String> = []
        var resolvedInitialFollowerUserIds: Set<String> = []
        if let currentUserId = resolvedCurrentUserId {
            for follow in follows where follow.userId == currentUserId {
                resolvedInitialFollowedUserIds.insert(follow.targetUserId)
            }
            for follow in follows where follow.targetUserId == currentUserId {
                resolvedInitialFollowerUserIds.insert(follow.userId)
            }
        }
        initialFollowedUserIds = resolvedInitialFollowedUserIds
        initialFollowerUserIds = resolvedInitialFollowerUserIds

        let hasPersistedLikedPostIds = UserDefaults.standard.object(forKey: TendiLocalDataStore.likedPostIdsKey) != nil
        let persistedLikedPostIds = Set(UserDefaults.standard.stringArray(forKey: TendiLocalDataStore.likedPostIdsKey) ?? [])
        likedPostIds = hasPersistedLikedPostIds
            ? persistedLikedPostIds
            : resolvedInitialLikedPostIds

        let hasPersistedFollowedUserIds = UserDefaults.standard.object(forKey: TendiLocalDataStore.followedUserIdsKey) != nil
        let persistedFollowedUserIds = Set(UserDefaults.standard.stringArray(forKey: TendiLocalDataStore.followedUserIdsKey) ?? [])
        followedUserIds = hasPersistedFollowedUserIds
            ? persistedFollowedUserIds
            : resolvedInitialFollowedUserIds
        blockedUserIds = Set(UserDefaults.standard.stringArray(forKey: TendiLocalDataStore.blockedUserIdsKey) ?? [])
        localComments = TendiLocalDataStore.loadLocalComments()
        localChatMessages = TendiLocalDataStore.loadLocalChatMessages()
        localAiChatMessages = TendiLocalDataStore.loadLocalAiChatMessages()
        currentProfileOverride = TendiLocalDataStore.loadCurrentProfileOverride(for: resolvedCurrentUser?.id)

        let coinBalanceKey = TendiLocalDataStore.coinBalanceKey(for: resolvedCurrentUser?.id)
        let hasPersistedCoinBalance = UserDefaults.standard.object(forKey: coinBalanceKey) != nil
        currentCoinBalanceValue = hasPersistedCoinBalance
            ? UserDefaults.standard.integer(forKey: coinBalanceKey)
            : (resolvedCurrentUser?.coinBalance ?? 0)
    }

    var followedVideoItems: [TendiHomeVideoItem] {
        videoItems.filter { item in
            followedUserIds.contains(item.user.id)
        }
    }

    var chatPreviewItems: [TendiChatPreviewItem] {
        let lastMessagesByPeerId = Dictionary(
            localChatMessages.map { ($0.peerUserId, $0) },
            uniquingKeysWith: { _, latest in latest }
        )

        return lastMessagesByPeerId.compactMap { peerUserId, lastMessage in
            guard let user = usersById[peerUserId] else { return nil }

            if let currentUser = currentUser,
               user.id == currentUser.id {
                return nil
            }

            if isBlocked(user) {
                return nil
            }

            guard isMutuallyFollowing(user) else {
                return nil
            }

            return TendiChatPreviewItem(user: user, lastMessage: lastMessage)
        }
        .sorted { firstItem, secondItem in
            guard let firstCreatedAt = firstItem.lastMessage?.createdAt,
                  let secondCreatedAt = secondItem.lastMessage?.createdAt else {
                return firstItem.title.localizedCaseInsensitiveCompare(secondItem.title) == .orderedAscending
            }

            return firstCreatedAt > secondCreatedAt
        }
    }

    func postItems(for user: TendiLocalUser) -> [TendiUserPostItem] {
        guard isBlocked(user) == false else { return [] }

        return userPostItems.filter { item in
            item.user.id == user.id
        }
    }

    func canSpendCoins(_ amount: Int) -> Bool {
        guard amount > 0 else { return true }
        return currentCoinBalanceValue >= amount
    }

    func updateCurrentUserProfile(nickname: String, bio: String, birthdayRawValue: String) {
        currentProfileOverride = TendiLocalProfileOverride(
            nickname: nickname,
            bio: bio,
            birthdayRawValue: birthdayRawValue
        )
        persistCurrentProfileOverride()
        NotificationCenter.default.post(name: .tendiCurrentUserProfileDidChange, object: currentUserProfile)
    }

    @discardableResult
    func spendCoins(_ amount: Int) -> Bool {
        guard amount > 0, currentCoinBalanceValue >= amount else {
            return false
        }

        currentCoinBalanceValue -= amount
        persistCurrentCoinBalance()
        NotificationCenter.default.post(name: .tendiCoinBalanceDidChange, object: nil)
        return true
    }

    @discardableResult
    func addCoins(_ amount: Int) -> Bool {
        guard amount > 0 else {
            return false
        }

        currentCoinBalanceValue += amount
        persistCurrentCoinBalance()
        NotificationCenter.default.post(name: .tendiCoinBalanceDidChange, object: nil)
        return true
    }

    func likeState(for item: TendiHomeVideoItem) -> TendiPostLikeState {
        likeState(for: item.post)
    }

    func likeState(for item: TendiFindPostItem) -> TendiPostLikeState {
        likeState(for: item.post)
    }

    func likeState(for item: TendiUserPostItem) -> TendiPostLikeState {
        switch item {
        case .video(let videoItem):
            return likeState(for: videoItem)
        case .image(let imageItem):
            return likeState(for: imageItem)
        }
    }

    private func likeState(for post: TendiLocalPost) -> TendiPostLikeState {
        let isLikedNow = likedPostIds.contains(post.id)
        return TendiPostLikeState(
            count: resolvedLikeCount(for: post, isLikedNow: isLikedNow),
            isLiked: isLikedNow
        )
    }

    func comments(for item: TendiHomeVideoItem) -> [TendiPostCommentItem] {
        comments(forPostId: item.id, baseComments: item.comments)
    }

    func comments(for item: TendiFindPostItem) -> [TendiPostCommentItem] {
        comments(forPostId: item.id, baseComments: item.comments)
    }

    private func comments(forPostId postId: String, baseComments: [TendiLocalComment]) -> [TendiPostCommentItem] {
        let addedComments = localComments.filter { comment in
            comment.postId == postId
        }
        let allComments = baseComments + addedComments

        return allComments.compactMap { comment in
            let user = usersById[comment.userId]
            if let user, isBlocked(user) {
                return nil
            }

            return TendiPostCommentItem(comment: comment, user: user)
        }
    }

    func commentCount(for item: TendiHomeVideoItem) -> Int {
        comments(for: item).count
    }

    func commentCount(for item: TendiFindPostItem) -> Int {
        comments(for: item).count
    }

    func followState(for item: TendiHomeVideoItem) -> TendiUserFollowState {
        followState(for: item.user)
    }

    func followState(for item: TendiFindPostItem) -> TendiUserFollowState {
        followState(for: item.user)
    }

    func followState(for user: TendiLocalUser) -> TendiUserFollowState {
        var isCurrentUser = false
        if let currentUser = currentUser {
            isCurrentUser = currentUser.id == user.id
        }

        let isFollowedNow = followedUserIds.contains(user.id)
        return TendiUserFollowState(
            isFollowed: isFollowedNow,
            canFollow: isCurrentUser == false,
            followerCount: resolvedFollowerCount(for: user, isFollowedNow: isFollowedNow)
        )
    }

    func isMutuallyFollowing(_ user: TendiLocalUser) -> Bool {
        if let currentUser = currentUser, currentUser.id == user.id {
            return true
        }

        guard isBlocked(user) == false else {
            return false
        }

        return followedUserIds.contains(user.id) && initialFollowerUserIds.contains(user.id)
    }

    @discardableResult
    func toggleLike(for item: TendiHomeVideoItem) -> TendiPostLikeState {
        toggleLike(for: item.post)
    }

    @discardableResult
    func toggleLike(for item: TendiFindPostItem) -> TendiPostLikeState {
        toggleLike(for: item.post)
    }

    @discardableResult
    func toggleLike(for item: TendiUserPostItem) -> TendiPostLikeState {
        switch item {
        case .video(let videoItem):
            return toggleLike(for: videoItem)
        case .image(let imageItem):
            return toggleLike(for: imageItem)
        }
    }

    private func toggleLike(for post: TendiLocalPost) -> TendiPostLikeState {
        let nextIsLiked = likedPostIds.contains(post.id) == false

        if nextIsLiked {
            likedPostIds.insert(post.id)
        } else {
            likedPostIds.remove(post.id)
        }

        persistLikeState()
        return likeState(for: post)
    }

    @discardableResult
    func toggleFollow(for item: TendiHomeVideoItem) -> TendiUserFollowState {
        toggleFollow(for: item.user)
    }

    @discardableResult
    func toggleFollow(for item: TendiFindPostItem) -> TendiUserFollowState {
        toggleFollow(for: item.user)
    }

    @discardableResult
    func toggleFollow(for user: TendiLocalUser) -> TendiUserFollowState {
        if let currentUser = currentUser, currentUser.id == user.id {
            return followState(for: user)
        }

        if isBlocked(user) {
            return followState(for: user)
        }

        if followedUserIds.contains(user.id) {
            followedUserIds.remove(user.id)
        } else {
            followedUserIds.insert(user.id)
        }

        persistFollowState()
        NotificationCenter.default.post(name: .tendiFollowStateDidChange, object: user)
        return followState(for: user)
    }

    @discardableResult
    func addComment(_ content: String, for item: TendiHomeVideoItem) -> TendiPostCommentItem? {
        addComment(content, postId: item.id)
    }

    @discardableResult
    func addComment(_ content: String, for item: TendiFindPostItem) -> TendiPostCommentItem? {
        addComment(content, postId: item.id)
    }

    private func addComment(_ content: String, postId: String) -> TendiPostCommentItem? {
        guard let currentUser = currentUser else { return nil }

        let comment = TendiLocalComment(
            id: UUID().uuidString,
            postId: postId,
            userId: currentUser.id,
            content: content,
            createdAt: ISO8601DateFormatter().string(from: Date())
        )

        localComments.append(comment)
        persistLocalComments()
        return TendiPostCommentItem(comment: comment, user: currentUser)
    }

    func chatMessages(with user: TendiLocalUser) -> [TendiChatMessageItem] {
        guard isBlocked(user) == false else { return [] }

        return localChatMessages
            .filter { message in
                message.peerUserId == user.id
            }
            .map { message in
                var isOutgoing = false
                if let currentUser = currentUser {
                    isOutgoing = message.senderUserId == currentUser.id
                }

                return TendiChatMessageItem(
                    message: message,
                    sender: usersById[message.senderUserId],
                    isOutgoing: isOutgoing
                )
            }
    }

    func aiChatMessages() -> [TendiAiChatMessageItem] {
        let currentAvatarImageName = currentUserProfile?.avatarImageName ?? "tendi_avatar"

        return localAiChatMessages.map { message in
            TendiAiChatMessageItem(
                message: message,
                avatarImageName: message.isOutgoing ? currentAvatarImageName : "ai_header"
            )
        }
    }

    @discardableResult
    func addChatMessage(_ content: String, to user: TendiLocalUser) -> TendiChatMessageItem? {
        guard let currentUser = currentUser, isBlocked(user) == false else { return nil }

        let message = TendiLocalChatMessage(
            id: UUID().uuidString,
            peerUserId: user.id,
            senderUserId: currentUser.id,
            content: content,
            createdAt: ISO8601DateFormatter().string(from: Date())
        )

        localChatMessages.append(message)
        persistLocalChatMessages()
        return TendiChatMessageItem(message: message, sender: currentUser, isOutgoing: true)
    }

    @discardableResult
    func addAiChatMessage(_ content: String, isOutgoing: Bool) -> TendiAiChatMessageItem? {
        let normalizedContent = content.trimmingCharacters(in: .whitespacesAndNewlines)
        guard normalizedContent.isEmpty == false else { return nil }

        let message = TendiLocalAiChatMessage(
            id: UUID().uuidString,
            content: normalizedContent,
            isOutgoing: isOutgoing,
            createdAt: ISO8601DateFormatter().string(from: Date())
        )

        localAiChatMessages.append(message)
        persistLocalAiChatMessages()

        let avatarImageName = isOutgoing ? (currentUserProfile?.avatarImageName ?? "tendi_avatar") : "ai_header"
        return TendiAiChatMessageItem(message: message, avatarImageName: avatarImageName)
    }

    func canBlock(_ user: TendiLocalUser) -> Bool {
        if let currentUser = currentUser, currentUser.id == user.id {
            return false
        }

        return true
    }

    func isBlocked(_ user: TendiLocalUser) -> Bool {
        blockedUserIds.contains(user.id)
    }

    @discardableResult
    func blockUser(_ user: TendiLocalUser) -> Bool {
        guard canBlock(user) else { return false }

        let inserted = blockedUserIds.insert(user.id).inserted
        if inserted {
            let wasFollowed = followedUserIds.remove(user.id) != nil
            persistBlockedUsers()
            persistFollowState()
            NotificationCenter.default.post(name: .tendiBlockedUsersDidChange, object: user)
            if wasFollowed {
                NotificationCenter.default.post(name: .tendiFollowStateDidChange, object: user)
            }
        }

        return inserted
    }

    @discardableResult
    func unblockUser(_ user: TendiLocalUser) -> Bool {
        guard blockedUserIds.remove(user.id) != nil else { return false }

        persistBlockedUsers()
        NotificationCenter.default.post(name: .tendiBlockedUsersDidChange, object: user)
        return true
    }

    static func bundleURL(forFileName fileName: String, subdirectory: String? = nil) -> URL? {
        guard fileName.isEmpty == false else { return nil }

        let fileNameNSString = fileName as NSString
        let fileExtension = fileNameNSString.pathExtension
        let resourceName = fileExtension.isEmpty ? fileName : fileNameNSString.deletingPathExtension
        let extensionValue = fileExtension.isEmpty ? nil : fileExtension

        if let subdirectory = subdirectory,
           let url = Bundle.main.url(forResource: resourceName, withExtension: extensionValue, subdirectory: subdirectory) {
            return url
        }

        return Bundle.main.url(forResource: resourceName, withExtension: extensionValue)
    }

    private func persistLikeState() {
        UserDefaults.standard.set(Array(likedPostIds), forKey: TendiLocalDataStore.likedPostIdsKey)
    }

    private func persistFollowState() {
        UserDefaults.standard.set(Array(followedUserIds), forKey: TendiLocalDataStore.followedUserIdsKey)
    }

    private func persistBlockedUsers() {
        UserDefaults.standard.set(Array(blockedUserIds), forKey: TendiLocalDataStore.blockedUserIdsKey)
    }

    private func persistLocalComments() {
        guard let data = try? JSONEncoder().encode(localComments) else { return }
        UserDefaults.standard.set(data, forKey: TendiLocalDataStore.localCommentsKey)
    }

    private func persistLocalChatMessages() {
        guard let data = try? JSONEncoder().encode(localChatMessages) else { return }
        UserDefaults.standard.set(data, forKey: TendiLocalDataStore.localChatMessagesKey)
    }

    private func persistLocalAiChatMessages() {
        guard let data = try? JSONEncoder().encode(localAiChatMessages) else { return }
        UserDefaults.standard.set(data, forKey: TendiLocalDataStore.localAiChatMessagesKey)
    }

    private func persistCurrentCoinBalance() {
        UserDefaults.standard.set(currentCoinBalanceValue, forKey: currentCoinBalanceKey)
    }

    private func persistCurrentProfileOverride() {
        guard let currentProfileOverride,
              let data = try? JSONEncoder().encode(currentProfileOverride) else {
            return
        }

        UserDefaults.standard.set(data, forKey: currentProfileOverrideKey)
    }

    private var currentCoinBalanceKey: String {
        TendiLocalDataStore.coinBalanceKey(for: currentUser?.id)
    }

    private var currentProfileOverrideKey: String {
        TendiLocalDataStore.profileOverrideKey(for: currentUser?.id)
    }

    private static func coinBalanceKey(for userId: String?) -> String {
        guard let userId, userId.isEmpty == false else {
            return currentCoinBalanceKeyPrefix
        }

        return "\(currentCoinBalanceKeyPrefix).\(userId)"
    }

    private static func profileOverrideKey(for userId: String?) -> String {
        guard let userId, userId.isEmpty == false else {
            return currentProfileOverrideKeyPrefix
        }

        return "\(currentProfileOverrideKeyPrefix).\(userId)"
    }

    private func sortedUsers(for userIds: Set<String>, includesBlockedUsers: Bool = false) -> [TendiLocalUser] {
        userIds
            .compactMap { usersById[$0] }
            .filter { user in
                if let currentUser = currentUser, currentUser.id == user.id {
                    return false
                }

                return includesBlockedUsers || isBlocked(user) == false
            }
            .sorted { firstUser, secondUser in
                firstUser.nickname.localizedCaseInsensitiveCompare(secondUser.nickname) == .orderedAscending
            }
    }

    private func resolvedLikeCount(for post: TendiLocalPost, isLikedNow: Bool) -> Int {
        var count = post.likeCount
        let wasLikedByCurrentUser = initialLikedPostIds.contains(post.id)

        if isLikedNow && wasLikedByCurrentUser == false {
            count += 1
        } else if isLikedNow == false && wasLikedByCurrentUser {
            count = max(0, count - 1)
        }

        return count
    }

    private func resolvedFollowerCount(for user: TendiLocalUser, isFollowedNow: Bool) -> Int {
        var count = user.followerCount
        let wasFollowedByCurrentUser = initialFollowedUserIds.contains(user.id)

        if isFollowedNow && wasFollowedByCurrentUser == false {
            count += 1
        } else if isFollowedNow == false && wasFollowedByCurrentUser {
            count = max(0, count - 1)
        }

        return count
    }

    private static func loadLocalComments() -> [TendiLocalComment] {
        guard let data = UserDefaults.standard.data(forKey: localCommentsKey),
              let comments = try? JSONDecoder().decode([TendiLocalComment].self, from: data) else {
            return []
        }

        return comments
    }

    private static func loadLocalChatMessages() -> [TendiLocalChatMessage] {
        guard let data = UserDefaults.standard.data(forKey: localChatMessagesKey),
              let messages = try? JSONDecoder().decode([TendiLocalChatMessage].self, from: data) else {
            return []
        }

        return messages
    }

    private static func loadLocalAiChatMessages() -> [TendiLocalAiChatMessage] {
        guard let data = UserDefaults.standard.data(forKey: localAiChatMessagesKey),
              let messages = try? JSONDecoder().decode([TendiLocalAiChatMessage].self, from: data) else {
            return []
        }

        return messages
    }

    private static func loadCurrentProfileOverride(for userId: String?) -> TendiLocalProfileOverride? {
        let key = profileOverrideKey(for: userId)
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(TendiLocalProfileOverride.self, from: data)
    }

    private static func loadPayload() -> TendiConfigPayload {
        let configURL = Bundle.main.url(forResource: "tendi_config", withExtension: "json", subdirectory: "Support")
            ?? Bundle.main.url(forResource: "tendi_config", withExtension: "json")

        guard let resolvedConfigURL = configURL,
              let data = try? Data(contentsOf: resolvedConfigURL),
              let payload = try? JSONDecoder().decode(TendiConfigPayload.self, from: data) else {
            return TendiConfigPayload()
        }

        return payload
    }
}

private struct TendiConfigPayload: Decodable {
    let follows: [TendiLocalFollow]
    let users: [TendiLocalUser]
    let comments: [TendiLocalComment]
    let posts: [TendiLocalPost]

    private enum CodingKeys: String, CodingKey {
        case follows = "qM8v"
        case users = "zP4n"
        case comments = "vN6s"
        case posts = "c9Rt"
    }

    init() {
        follows = []
        users = []
        comments = []
        posts = []
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        follows = try container.decodeIfPresent([TendiLocalFollow].self, forKey: .follows) ?? []
        users = try container.decodeIfPresent([TendiLocalUser].self, forKey: .users) ?? []
        comments = try container.decodeIfPresent([TendiLocalComment].self, forKey: .comments) ?? []
        posts = try container.decodeIfPresent([TendiLocalPost].self, forKey: .posts) ?? []
    }
}

extension Notification.Name {
    static let tendiBlockedUsersDidChange = Notification.Name("tendiBlockedUsersDidChange")
    static let tendiFollowStateDidChange = Notification.Name("tendiFollowStateDidChange")
    static let tendiCoinBalanceDidChange = Notification.Name("tendiCoinBalanceDidChange")
    static let tendiCurrentUserProfileDidChange = Notification.Name("tendiCurrentUserProfileDidChange")
}
