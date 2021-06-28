// Written by Rabia Alhaffar in June 22, 2021
// hxtizen, Haxe externs for Tizen SDK API!
// Updated: June 28, 2021

// NOTE: This is externs for the JavaScript target!

package tizenjs;

import haxe.io.Bytes;
import haxe.io.UInt8Array;
import haxe.Int64;
import haxe.extern.EitherType;
import js.html.Blob;

/**
 * ...
 * @author Rabia Alhaffar
 */
typedef FileReference = EitherType<String, Dynamic>;
typedef TizenCallback = haxe.Constraints.Function;

@:enum abstract FileMode(String) {
	var a;
    var r;
    var rw;
    var rwo;
    var w;
}

@:enum abstract ArchiveCompressionLevel(String) {
	var STORE;
	var FAST;
	var NORMAL;
	var BEST;
}

class ArchiveManager {
	public function new() {}
	extern public function open(file: FileReference, mode: EitherType<String, FileMode>, onsuccess: TizenCallback, ?onerror: TizenCallback, ?options: ArchiveFileOptions): Int64;
	extern public function abort(operationIdentifier: Int64): Void;
}

class ArchiveFile {
	public function new() {}
	extern public var mode(default, null): EitherType<String, FileMode>;
	extern public var decompressedSize(default, null): Int64;
	extern public function add(sourceFile: FileReference, ?onsuccess: TizenCallback, ?onerror: TizenCallback, ?onprogress: TizenCallback, ?options: ArchiveFileEntryOptions): Int64;
	extern public function extractAll(destinationDirectory: FileReference, ?onsuccess: TizenCallback, ?onerror: TizenCallback, ?onprogress: TizenCallback, ?overwrite: Bool): Int64;
	extern public function getEntries(onsuccess: TizenCallback, ?onerror: TizenCallback): Int64;
	extern public function getEntryByName(name: String, onsuccess: TizenCallback, ?onerror: TizenCallback): Int64;
	extern public function close(): Void;
}

typedef ArchiveFileOptions = {
	var overwrite: Bool;
}

typedef ArchiveFileEntryOptions = {
	var destination: String;
	var stripSourceDirectory: Bool;
	var compressionLevel: EitherType<String, ArchiveCompressionLevel>;
}

class ArchiveFileEntry {
	public function new() {}
	extern public var name(default, null): String;
	extern public var size(default, null): Int64;
	extern public var compressedSize(default, null): Int64;
	extern public var modified(default, null): Date;
	extern public function extract(destinationDirectory: FileReference, ?onsuccess: TizenCallback, ?onerror: TizenCallback, ?onprogress: TizenCallback, ?stripName: Bool, ?overwrite: Bool): Void;
}

typedef Path = String;

@:enum abstract FileSystemStorageType(String) {
    var INTERNAL;
    var EXTERNAL;
}

@:enum abstract FileSystemStorageState(String) {
    var MOUNTED;
    var REMOVED;
    var UNMOUNTABLE;
}

@:enum abstract BaseSeekPosition(String) {
    var BEGIN;
    var CURRENT;
    var END;
}

class FileSystemManager {
    public function new() {}
    extern public var maxNameLength(default, null): Int64;
    extern public var maxPathLength(default, null): Int64;
    extern public function openFile(path: Path, openMode: FileMode, ?makeParents: Bool): FileHandle;
    extern public function createDirectory(path: Path, ?makeParents: Bool, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function deleteFile(path: Path, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function deleteDirectory(path: Path, ?recursive: Bool, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function copyFile(sourcePath: Path, destinationPath: Path, ?overwrite: Bool, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function copyDirectory(sourcePath: Path, destinationPath: Path, ?overwrite: Bool, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function moveFile(sourcePath: Path, destinationPath: Path, ?overwrite: Bool, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function moveDirectory(sourcePath: Path, destinationPath: Path, ?overwrite: Bool, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function rename(path: Path, newName: String, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function listDirectory(path: Path, successCallback: TizenCallback, ?errorCallback: TizenCallback, ?filter: FileFilter): Void;
    extern public function toURI(path: Path): String;
    extern public function isFile(path: Path): Bool;
    extern public function isDirectory(path: Path): Bool;
    extern public function pathExists(path: Path): Bool;
    extern public function getDirName(path: String): String;
    extern public function getStorage(label: String, onsuccess: TizenCallback, ?onerror: TizenCallback): Void;
    extern public function listStorages(onsuccess: TizenCallback, ?onerror: TizenCallback): Void;
    extern public function addStorageStateChangeListener(onsuccess: TizenCallback, ?onerror: TizenCallback): Int64;
    extern public function removeStorageStateChangeListener(watchId: Int64): Void;
}

class FileHandle {
    public function new() {}
    extern public var path(default, null): Path;
    extern public function seek(offset: Int64, ?whence: EitherType<String, BaseSeekPosition>): Int64;
    extern public function seekNonBlocking(offset: Int64, ?onsuccess: TizenCallback, ?onerror: TizenCallback, ?whence: EitherType<String, BaseSeekPosition>): Void;
    extern public function readString(?count: Int64, ?inputEncoding: String): String;
    extern public function readStringNonBlocking(?onsuccess: TizenCallback, ?onerror: TizenCallback, ?count: Int64, ?inputEncoding: String): Void;
    extern public function writeString(inputString: String, outputEncoding: String): Int64;
    extern public function writeStringNonBlocking(inputString: String, ?onsuccess: TizenCallback, ?onerror: TizenCallback, ?inputEncoding: String): Void;
    extern public function readBlob(?size: Int64): Blob;
    extern public function readBlobNonBlocking(?onsuccess: TizenCallback, ?onerror: TizenCallback, ?size: Int64): Void;
    extern public function writeBlob(blob: Blob): Void;
    extern public function writeBlobNonBlocking(blob: Blob, ?onsuccess: TizenCallback, ?onerror: TizenCallback): Void;
    extern public function readData(?size: Int64): UInt8Array;
    extern public function readDataNonBlocking(?onsuccess: TizenCallback, ?onerror: TizenCallback, ?size: Int64): Void;
    extern public function writeData(data: UInt8Array): Void;
    extern public function writeDataNonBlocking(data: UInt8Array, ?onsuccess: TizenCallback, ?onerror: TizenCallback): Void;
    extern public function flush(): Void;
    extern public function flushNonBlocking(?onsuccess: TizenCallback, ?onerror: TizenCallback): Void;
    extern public function sync(): Void;
    extern public function syncNonBlocking(?onsuccess: TizenCallback, ?onerror: TizenCallback): Void;
    extern public function close(): Void;
    extern public function closeNonBlocking(?onsuccess: TizenCallback, ?onerror: TizenCallback): Void;
}

typedef FileSystemStorage = {
    var label: String;
    var type: EitherType<String, FileSystemStorageType>;
    var state: EitherType<String, FileSystemStorageState>;
}

typedef FileFilter = {
    var name: String;
    var isFile: Bool;
    var isDirectory: Bool;
    var startModified: Date;
    var endModified: Date;
    var startCreated: Date;
    var endCreated: Date;
}

typedef ByteStream = Bytes;//UInt8Array;

@:enum abstract FilterMatchFlag(String) {
    var EXACTLY;
    var FULLSTRING;
    var CONTAINS;
    var STARTSWITH;
    var ENDSWITH;
    var EXISTS;
}

@:enum abstract SortModeOrder(String) {
    var ASC;
    var DESC;
}

@:enum abstract CompositeFilterType(String) {
    var UNION;
    var INTERSECTION;
}

@:enum abstract BundleValueType(String) {
    var STRING;
    var STRING_ARRAY;
    var BYTES;
    var BYTES_ARRAY;
}

@:native("tizen.Bundle")
extern class Bundle {
    public function new(?object: Dynamic);
    extern public function get(key: String): Any;
    extern public function set(key: String, value: Any): Void;
    extern public function typeOf(key: String): EitherType<String, BundleValueType>;
    extern public function forEach(callback: TizenCallback): Void;
    extern public function toJSON(): Dynamic;
    extern public function toString(): String;
}

class AbstractFilter {
    public function new() {}
}

@:native("tizen.AttributeFilter")
extern class AttributeFilter extends AbstractFilter {
    extern public function new(attributeName: String, ?matchFlag: EitherType<FilterMatchFlag, String>, ?matchValue: Any);
    extern public var attributeName(default, null): String;
    extern public var matchFlag(default, null): EitherType<FilterMatchFlag, String>;
    extern public var matchValue(default, null): Any;
}

@:native("tizen.AttributeRangeFilter")
extern class AttributeRangeFilter extends AbstractFilter {
    extern public function new(attributeName: String, ?initialValue: Any, ?endValue: Any);
    extern public var attributeName(default, null): String;
    extern public var initialValue(default, null): Any;
    extern public var endValue(default, null): Any;
}

@:native("tizen.CompositeFilter")
extern class CompositeFilter extends AbstractFilter {
    extern public function new(type: CompositeFilterType, ?filters: Array<AbstractFilter>);
    extern public var type(default, null): CompositeFilterType;
    extern public var filters(default, null): Array<AbstractFilter>;
}

@:native("tizen.SortMode")
extern class SortMode {
    public function new(attributeName: String, ?order: EitherType<String, SortModeOrder>);
    extern public var attributeName(default, null): String;
    extern public var order(default, null): EitherType<String, SortModeOrder>;
}

@:native("tizen.SimpleCoordinates")
extern class SimpleCoordinates {
    public function new(latitude: Float, longitude: Float);
    extern public var latitude(default, null): Float;
    extern public var longitude(default, null): Float;
}

class WebAPIException {
    public function new() {}
    public static var INDEX_SIZE_ERR(default, null): Int;
    public static var DOMSTRING_SIZE_ERR(default, null): Int;
    public static var HIERARCHY_REQUEST_ERR(default, null): Int;
    public static var WRONG_DOCUMENT_ERR(default, null): Int;
    public static var INVALID_CHARACTER_ERR(default, null): Int;
    public static var NO_DATA_ALLOWED_ERR(default, null): Int;
    public static var NO_MODIFICATION_ALLOWED_ERR(default, null): Int;
    public static var NOT_FOUND_ERR(default, null): Int;
    public static var NOT_SUPPORTED_ERR(default, null): Int;
    public static var INUSE_ATTRIBUTE_ERR(default, null): Int;
    public static var INVALID_STATE_ERR(default, null): Int;
    public static var SYNTAX_ERR(default, null): Int;
    public static var INVALID_MODIFICATION_ERR(default, null): Int;
    public static var NAMESPACE_ERR(default, null): Int;
    public static var INVALID_ACCESS_ERR(default, null): Int;
    public static var VALIDATION_ERR(default, null): Int;
    public static var TYPE_MISMATCH_ERR(default, null): Int;
    public static var SECURITY_ERR(default, null): Int;
    public static var NETWORK_ERR(default, null): Int;
    public static var ABORT_ERR(default, null): Int;
    public static var URL_MISMATCH_ERR(default, null): Int;
    public static var QUOTA_EXCEEDED_ERR(default, null): Int;
    public static var TIMEOUT_ERR(default, null): Int;
    public static var INVALID_NODE_TYPE_ERR(default, null): Int;
    public static var DATA_CLONE_ERR(default, null): Int;
    extern public static var code(default, null): UInt;
    extern public static var name(default, null): String;
    extern public static var message(default, null): String;
}

typedef WebAPIError = {
    var code: Int64;
    var name: String;
    var message: String;
}

typedef AccountId = Int64;

typedef AccountInit = {
    var userName: String;
    var iconUri: String;
}

typedef AccountProvider = {
    var applicationId: ApplicationId;
    var displayName: String;
    var iconUri: String;
    var smallIconUri: String;
    var capabilities: Array<String>;
    var isMultipleAccountSupported: Bool;
}

@:native("tizen.Account")
extern class Account {
    public function new(provider: AccountProvider, ?accountInitDict: AccountInit);
    extern public var id(default, null): AccountId;
    extern public var userName(default, null): String;
    extern public var iconUri(default, null): String;
    extern public var provider(default, null): AccountProvider;
    extern public function setExtendedData(key: String, value: String): Void;
    extern public function getExtendedData(key_or_successCallback: EitherType<String, TizenCallback>, ?errorCallback: TizenCallback): EitherType<String, Void>;
}

class AccountManager {
    public function new() {}
    extern public function add(account: Account): Void;
    extern public function remove(accountId: AccountId): Void;
    extern public function update(account: Account): Void;
    extern public function getAccount(accountId: AccountId): Account;
    extern public function getAccounts(successCallback: TizenCallback, ?errorCallback: TizenCallback, applicationId: String): Void;
    extern public function getProvider(accountId: AccountId): AccountProvider;
    extern public function getProviders(successCallback: TizenCallback, ?errorCallback: TizenCallback, ?capability: String): Void;
    extern public function addAccountListener(callback: TizenCallback): Int64;
    extern public function removeAccountListener(watchId: Int64): Void;
}

typedef AccountChangeCallback = {
    var onadded: TizenCallback;
    var onremoved: TizenCallback;
    var onupdated: TizenCallback;
}

typedef AlarmId = String;

class Alarm {
    public function new() {}
    extern public var id(default, null): AlarmId;
}

@:native("tizen.AlarmRelative")
extern class AlarmRelative extends Alarm {
    extern public function new(delay: Int64, ?period: Int64);
    extern public var delay(default, null): Int64;
    extern public var period(default, null): Int64;
    extern public function getRemainingSeconds(): Int64;
}

@:native("tizen.AlarmAbsolute")
extern class AlarmAbsolute extends Alarm {
    extern public function new(date: Date, ?daysOfTheWeek: Array<ByDayValue>);
    extern public var date(default, null): Date;
    extern public var daysOfTheWeek(default, null): Array<ByDayValue>;
    extern public function getNextScheduleDate(): Date;
}

class AlarmManager {
    public function new() {}
    extern public var PERIOD_MINUTE(default, null): Int64;
    extern public var PERIOD_HOUR(default, null): Int64;
    extern public var PERIOD_DAY(default, null): Int64;
    extern public var PERIOD_WEEK(default, null): Int64;
    extern public function add(alarm: Alarm, applicationId: ApplicationId, ?appControl: ApplicationControl): Void;
    extern public function addAlarmNotification(alarm: Alarm, notification: Notification): Void;
    extern public function remove(id: AlarmId): Void;
    extern public function removeAll(): Void;
    extern public function get(id: AlarmId): Alarm;
    extern public function getAlarmNotification(id: AlarmId): UserNotification;
    extern public function getAll(): Array<Alarm>;
}

typedef ApplicationId = String;
typedef ApplicationContextId = String;
typedef UserEventData = Dynamic;
typedef EventData = EitherType<UserEventData, SystemEventData>;

@:enum abstract ApplicationControlLaunchMode(String) {
    var SINGLE;
    var GROUP;
}

@:enum abstract ApplicationUsageMode(String) {
    var RECENTLY;
    var FREQUENTLY;
}

typedef ApplicationUsageFilter = {
    var ?timeSpan: Int64;
    var ?startTime: Date;
    var ?endTime: Date;
}

typedef EventInfo = {
    var appId: ApplicationId;
    var name: String;
}

class ApplicationManager {
    public function new() {}
    extern public function getCurrentApplication(): Application;
    extern public function kill(contextId: ApplicationContextId, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function launch(id: ApplicationId, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function launchAppControl(appControl: ApplicationControl, ?id: ApplicationId, ?successCallback: TizenCallback, ?errorCallback: TizenCallback, ?replyCallback: TizenCallback): Void;
    extern public function findAppControl(appControl: ApplicationControl, successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function getAppsContext(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function getAppContext(?contextId: ApplicationContextId): ApplicationContext;
    extern public function getAppsInfo(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function getAppInfo(?id: ApplicationId): ApplicationInformation;
    extern public function getAppCerts(?id: ApplicationId): Array<ApplicationCertificate>;
    extern public function getAppSharedURI(?id: ApplicationId): String;
    extern public function getAppMetaData(?id: ApplicationId): Array<ApplicationMetaData>;
    extern public function getBatteryUsageInfo(successCallback: TizenCallback, ?errorCallback: TizenCallback, ?days: Int64, ?limit: Int64): Void;
    extern public function getAppsUsageInfo(successCallback: TizenCallback, ?errorCallback: TizenCallback, ?mode: EitherType<String, ApplicationUsageMode>, ?filter: ApplicationUsageFilter, ?limit: Int64): Void;
    extern public function addAppStatusChangeListener(eventCallback: TizenCallback, ?appId: ApplicationId): Int64;
    extern public function removeAppStatusChangeListener(watchId: Int64): Void;
}

class Application {
    public function new() {}
    extern public var appInfo(default, null): ApplicationInformation;
    extern public var contextId(default, null): ApplicationContextId;
    extern public function exit(): Void;
    extern public function hide(): Void;
    extern public function getRequestedAppControl(): RequestedApplicationControl;
    extern public function addEventListener(event: EventInfo, callback: TizenCallback): Int64;
    extern public function removeEventListener(watchId: Int64): Void;
    extern public function broadcastEvent(event: EventInfo, data: UserEventData): Void;
    extern public function broadcastTrustedEvent(event: EventInfo, data: UserEventData): Void;
}

typedef ApplicationInformation = {
    var id: ApplicationId;
    var name: String;
    var iconPath: String;
    var version: String;
    var show: Bool;
    var categories: Array<String>;
    var installDate: Date;
    var size: Int64;
    var packageId: PackageId;
}

typedef ApplicationContext = {
    var id: ApplicationContextId;
    var appId: ApplicationId;
}

typedef ApplicationBatteryUsage = {
    var appId: ApplicationId;
    var batteryUsage: Float;
}

typedef ApplicationUsage = {
    var appId: ApplicationId;
    var totalCount: Int64;
    var totalDuration: Int64;
    var lastTime: Date;
}

@:native("tizen.ApplicationControlData")
extern class ApplicationControlData {
    public function new(key: String, value: Array<String>);
    extern public var key(default, null): String;
    extern public var value(default, null): Array<String>;
}

@:native("tizen.ApplicationControl")
extern class ApplicationControl {
    public function new(operation: String, ?uri: String, ?mime: String, ?category: String, ?data: Array<ApplicationControlData>, ?launchMode: EitherType<ApplicationControlLaunchMode, String>);
    extern public var operation(default, null): String;
    extern public var uri(default, null): String;
    extern public var mime(default, null): String;
    extern public var category(default, null): String;
    extern public var data(default, null): Array<ApplicationControlData>;
    extern public var launchMode(default, null): EitherType<String, ApplicationControlLaunchMode>;
}

class RequestedApplicationControl {
    public function new() {}
    extern public var appControl(default, null): ApplicationControl;
    extern public var callerAppId(default, null): ApplicationId;
    extern public function replyResult(?data: Array<ApplicationControlData>): Void;
    extern public function replyFailure(): Void;
}

typedef PackageId = String;

typedef ApplicationCertificate = {
    var type: String;
    var value: String;
}

typedef ApplicationMetaData = {
    var key: String;
    var value: String;
}

typedef SystemEventData = {
    var value: String;
    var type: String;
}

class BadgeManager {
    public function new() {}
    extern public var maxBadgeCount(default, null): Int64;
    extern public function setBadgeCount(appId: ApplicationId, count: Int64): Void;
    extern public function getBadgeCount(appId: ApplicationId): Int64;
    extern public function addChangeListener(appIdList: Array<ApplicationId>, successCallback: TizenCallback): Void;
    extern public function removeChangeListener(appIdList: Array<ApplicationId>): Void;
}

@:enum abstract DataType(String) {
    var MAP;
    var SQL;
}

@:enum abstract EventType(String) {
    var SQL_UPDATE;
    var SQL_INSERT;
    var SQL_DELETE;
    var MAP_SET;
    var MAP_ADD;
    var MAP_REMOVE;
}

typedef RowData = {
    var columns: Array<String>;
    var values: Array<String>;
}

class DataControlManager {
    public function new() {}
    extern public function getDataControlConsumer(providerId: String, dataId: String, type: EitherType<String, DataType>): DataControlConsumerObject;
}

class DataControlConsumerObject {
    public function new() {}
    extern public var type(default, null): EitherType<String, DataType>;
    extern public var providerId(default, null): String;
    extern public var dataId(default, null): String;
    extern public function addChangeListener(dataChangeCallback: TizenCallback, ?errorCallback: TizenCallback): Int64;
    extern public function removeChangeListener(watchId: Int64): Void;
}

class SQLDataControlConsumer extends DataControlConsumerObject {
    public function SQLDataControlConsumer() {}
    extern public function insert(reqId: Int64, insertionData: RowData, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function update(reqId: Int64, updateData: RowData, where: String, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function remove(reqId: Int64, where: String, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function select(reqId: Int64, columns: Array<String>, where: String, successCallback: TizenCallback, ?errorCallback: TizenCallback, ?page: Int64, ?maxNumberPerPage: Int64, ?order: String): Void;
}

class MappedDataControlConsumer extends DataControlConsumerObject {
    public function MappedDataControlConsumer() {}
    extern public function addValue(reqId: Int64, key: String, value: String, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function removeValue(reqId: Int64, key: String, value: String, successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function getValue(reqId: Int64, key: String, successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function updateValue(reqId: Int64, key: String, oldValue: String, newValue: String, successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

typedef InputDeviceKeyName = String;

typedef InputDeviceKey = {
    var name: String;
    var code: Int64;
}

class InputDeviceManager {
    public function new() {}
    extern public function getSupportedKeys(): Array<InputDeviceKey>;
    extern public function getKey(keyName: InputDeviceKeyName): InputDeviceKey;
    extern public function registerKey(keyName: InputDeviceKeyName): Void;
    extern public function unregisterKey(keyName: InputDeviceKeyName): Void;
    extern public function registerKeyBatch(keyNames: Array<InputDeviceKeyName>, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function unregisterKeyBatch(keyNames: Array<InputDeviceKeyName>, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

typedef Octet = Dynamic;
typedef StringDataItemValue = EitherType<String, Array<String>>;
typedef ByteStreamDataItemValue = EitherType<ByteStream, Array<ByteStream>>;
typedef MessagePortDataItem = EitherType<MessagePortStringDataItem, MessagePortByteStreamDataItem>;

typedef MessagePortStringDataItem = {
    var key: String;
    var value: StringDataItemValue;
}

typedef MessagePortByteStreamDataItem = {
    var key: String;
    var value: ByteStreamDataItemValue;
}

class MessagePortManager {
    public function new() {}
    extern public function requestLocalMessagePort(localMessagePortName: String): LocalMessagePort;
    extern public function requestTrustedLocalMessagePort(localMessagePortName: String): LocalMessagePort;
    extern public function requestRemoteMessagePort(appId: ApplicationId, remoteMessagePortName: String): RemoteMessagePort;
    extern public function requestTrustedRemoteMessagePort(appId: ApplicationId, remoteMessagePortName: String): RemoteMessagePort;
}

class LocalMessagePort {
    public function new() {}
    extern public var messagePortName(default, null): String;
    extern public var isTrusted(default, null): Bool;
    extern public function addMessagePortListener(listener: TizenCallback): Int64;
    extern public function removeMessagePortListener(watchId: Int64): Void;
}

class RemoteMessagePort {
    public function new() {}
    extern public var messagePortName(default, null): String;
    extern public var appId(default, null): ApplicationId;
    extern public var isTrusted(default, null): Bool;
    extern public function sendMessage(data: Array<MessagePortDataItem>, ?localMessagePort: LocalMessagePort): Void;
}

typedef NotificationId = String;

@:enum abstract NotificationType(String) {
    var STATUS;
}

@:enum abstract UserNotificationType(String) {
    var SIMPLE;
    var THUMBNAIL;
    var ONGOING;
    var PROGRESS;
}

@:enum abstract NotificationProgressType(String) {
    var PERCENTAGE;
    var BYTE;
}

@:enum abstract LEDCustomFlags(String) {
    var LED_CUSTOM_DUTY_ON;
    var LED_CUSTOM_DEFAULT;
}

typedef UserNotificationInit = {
    var ?content: String;
    var ?textContents: NotificationTextContentInfo;
    var ?images: NotificationImageInfo;
    var ?thumbnails: NotificationThumbnailInfo;
    var ?actions: NotificationActionInfo;
    var ?groupContents: NotificationGroupContentInfo;
    var ?leds: NotificationLedInfo;
}

typedef NotificationTextContentInfo = {
    var ?progressType: EitherType<String, NotificationProgressType>;
    var ?progressValue: Int64;
    var ?eventsNumber: Int64;
    var ?detailInfo: Array<NotificationDetailInfo>;
    var ?buttonsTexts: Array<String>;
    var ?contentForOff: String;
}

typedef NotificationImageInfo = {
    var ?iconPath: String;
    var ?subIconPath: String;
    var ?indicatorIconPath: String;
    var ?lockScreenIconPath: String;
    var ?buttonIconPaths: Array<String>;
    var ?backgroundImagePath: String;
}

typedef NotificationThumbnailInfo = {
    var ?lockScreenThumbnailIconPath: String;
    var ?thumbnailIconPath: String;
    var ?thumbnails: Array<String>;
}

typedef NotificationActionInfo = {
    var ?soundPath: String;
    var ?vibration: Bool;
    var ?appControl: ApplicationControl;
    var ?appId: ApplicationId;
}

typedef NotificationGroupContentInfo = {
    var ?groupTitle: String;
    var ?groupContent: String;
    var ?groupContentForOff: String;
}

typedef NotificationLedInfo = {
    var ?ledColor: String;
    var ledOnPeriod: Int64;
    var ledOffPeriod: Int64;
}

class NotificationManager {
    public function new() {}
    extern public function post(notification: Notification): Void;
    extern public function update(notification: Notification): Void;
    extern public function remove(id: NotificationId): Void;
    extern public function removeAll(): Void;
    extern public function getNotification(id: NotificationId): Notification;
    extern public function getAllNotifications(): Array<Notification>;
    extern public function playLEDCustomEffect(timeOn: Int64, timeOff: Int64, color: String, flags: Array<LEDCustomFlags>): Void;
    extern public function stopLEDCustomEffect(): Void;
    extern public function saveNotificationAsTemplate(name: String, notification: Notification): Void;
    extern public function createNotificationFromTemplate(name: String): UserNotification;
}

class Notification {
    public function new() {}
    extern public var id(default, null): NotificationId;
    extern public var type(default, null): EitherType<String, NotificationType>;
    extern public var postedTime(default, null): Date;
    extern public var title(default, null): String;
    extern public var content(default, null): String;
}

@:native("tizen.UserNotification")
extern class UserNotification extends Notification {
    extern public function new(userType: EitherType<String, UserNotificationType>, title: String, ?notificationGroupedInitDict: UserNotificationInit);
    extern public var userType(default, null): EitherType<String, UserNotificationType>;
    extern public var textContents(default, null): NotificationTextContentInfo;
    extern public var images(default, null): NotificationImageInfo;
    extern public var thumbnails(default, null): NotificationThumbnailInfo;
    extern public var actions(default, null): NotificationActionInfo;
    extern public var groupContents(default, null): NotificationGroupContentInfo;
    extern public var leds(default, null): NotificationLedInfo;
}

@:native("tizen.NotificationDetailInfo")
extern class NotificationDetailInfo {
    public function new(mainText: String, ?subText: String);
    extern public var mainText(default, null): String;
    extern public var subText(default, null): String;
}

class PackageManager {
    public function new() {}
    extern public function install(packageFileURI: String, progressCallback: PackageProgressCallback, ?errorCallback: TizenCallback): Void;
    extern public function uninstall(id: PackageId, progressCallback: PackageProgressCallback, ?errorCallback: TizenCallback): Void;
    extern public function getPackagesInfo(progressCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function getPackageInfo(?id: PackageId): PackageInformation;
    extern public function setPackageInfoEventListener(eventCallback: PackageInformationEventCallback): Void;
    extern public function unsetPackageInfoEventListener(): Void;
}

typedef PackageProgressCallback = {
    var onprogress: TizenCallback;
    var oncomplete: TizenCallback;
}

typedef PackageInformationEventCallback = {
    var oninstalled: TizenCallback;
    var ononupdated: TizenCallback;
    var onuninstalled: TizenCallback;
}

typedef PackageInformation = {
    var id: PackageId;
    var name: String;
    var iconPath: String;
    var version: String;
    var totalSize: Int64;
    var dataSize: Int64;
    var lastModified: Date;
    var author: String;
    var description: String;
    var appIds: Array<ApplicationId>;
}

// tizen.package => tizen.packages

typedef PreferenceValueType = EitherType<EitherType<String, Bool>, EitherType<Int64, Float>>;

typedef PreferenceData = {
    var key: String;
    var value: PreferenceValueType;
}

class PreferenceManager {
    public function new() {}
    extern public function getAll(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function setValue(key: String, value: PreferenceValueType): Void;
    extern public function getValue(key: String): PreferenceValueType;
    extern public function remove(key: String): Void;
    extern public function removeAll(): Void;
    extern public function exists(key: String): Bool;
    extern public function setChangeListener(key: String, listener: TizenCallback): Void;
    extern public function unsetChangeListener(key: String): Void;
}

typedef WidgetId = String;
typedef WidgetInstanceId = String;

@:enum abstract WidgetSizeType(String) {
    var SIZE_1x1 = "1x1";
    var SIZE_2x1 = "2x1";
    var SIZE_2x2 = "2x2";
    var SIZE_4x1 = "4x1";
    var SIZE_4x2 = "4x2";
    var SIZE_4x3 = "4x3";
    var SIZE_4x4 = "4x4";
    var SIZE_4x5 = "4x5";
    var SIZE_4x6 = "4x6";
    var SIZE_EASY_1x1 = "EASY_1x1";
    var SIZE_EASY_3x1 = "EASY_3x1";
    var SIZE_EASY_3x3 = "EASY_3x3";
    var SIZE_FULL = "FULL";
}

@:enum abstract WidgetStateType(String) {
    var CREATE;
    var DESTROY;
    var PAUSE;
    var RESUME;
}

class WidgetServiceManager {
    public function new() {}
    extern public function getWidget(widgetId: WidgetId): Widget;
    extern public function getWidgets(successCallback: TizenCallback, ?errorCallback: TizenCallback, ?packageId: PackageId): Void;
    extern public function getPrimaryWidgetId(id: EitherType<PackageId, ApplicationId>): WidgetId;
    extern public function getSize(sizeType: EitherType<String, WidgetSizeType>): WidgetSize;
}

class Widget {
    public function new() {}
    extern public var id(default, null): WidgetId;
    extern public var applicationId(default, null): ApplicationId;
    extern public var setupApplicationId(default, null): ApplicationId;
    extern public var packageId(default, null): PackageId;
    extern public var noDisplay(default, null): Bool;
    extern public function getName(?locale: String): String;
    extern public function getInstances(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function getVariant(sizeType: EitherType<String, WidgetSizeType>): WidgetVariant;
    extern public function getVariants(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function addStateChangeListener(listener: TizenCallback): Int64;
    extern public function removeStateChangeListener(watchId: Int64): Void;
}

typedef WidgetSize = {
    var width: Int64;
    var height: Int64;
}

typedef WidgetVariant = {
    var sizeType: EitherType<String, WidgetSizeType>;
    var width: Int64;
    var height: Int64;
    var previewImagePath: String;
    var needsMouseEvents: Bool;
    var needsTouchEffect: Bool;
    var needsFrame: Bool;
}

class WidgetInstance {
    public function new() {}
    extern public var widget(default, null): Widget;
    extern public var id(default, null): WidgetInstanceId;
    extern public function changeUpdatePeriod(seconds: Float): Void;
    extern public function sendContent(data: Dynamic, updateIfPaused: Bool): Void;
    extern public function getContent(successCallback: TizenCallback, errorCallback: TizenCallback): Void;
}

typedef ContentId = String;
typedef ContentDirectoryId = String;
typedef PlaylistId = String;

@:enum abstract ContentType(String) {
    var IMAGE;
    var VIDEO;
    var AUDIO;
    var OTHER;
}

@:enum abstract AudioContentLyricsType(String) {
    var SYNCHRONIZED;
    var UNSYNCHRONIZED;
}

@:enum abstract ImageContentOrientation(String) {
    var NORMAL;
    var FLIP_HORIZONTAL;
    var ROTATE_180;
    var FLIP_VERTICAL;
    var TRANSPOSE;
    var ROTATE_90;
    var TRANSVERSE;
    var ROTATE_270;
}

@:enum abstract ContentDirectoryStorageType(String) {
    var INTERNAL;
    var EXTERNAL;
}

class ContentManager {
    public function new() {}
    extern public function update(content: Content): Void;
    extern public function updateBatch(contents: Array<Content>, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function getDirectories(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function find(successCallback: TizenCallback, ?errorCallback: TizenCallback, ?directoryId: ContentDirectoryId, ?filter: AbstractFilter, ?sortMode: SortMode, ?count: Int64, ?offset: Int64): Void;
    extern public function scanFile(contentURI: String, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function scanDirectory(contentDirURI: String, recursive: Bool, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function cancelScanDirectory(contentDirURI: String): Void;
    extern public function addChangeListener(changeCallback: ContentChangeCallback): Int64;
    extern public function removeChangeListener(listenerId: Int64): Void;
    extern public function getPlaylists(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function createPlaylist(name: String, successCallback: TizenCallback, ?errorCallback: TizenCallback, ?sourcePlaylist: Playlist): Void;
    extern public function removePlaylist(id: PlaylistId, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function createThumbnail(content: Content, successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

typedef ContentChangeCallback = {
    var oncontentadded: TizenCallback;
    var oncontentupdated: TizenCallback;
    var oncontentremoved: TizenCallback;
    var oncontentdiradded: TizenCallback;
    var oncontentdirupdated: TizenCallback;
    var oncontentdirremoved: TizenCallback;
}

typedef ContentDirectory = {
    var id: ContentDirectoryId;
    var directoryURI: String;
    var title: String;
    var storageType: EitherType<String, ContentDirectoryStorageType>;
    var ?modifiedDate: Date;
}

class Content {
    public function new() {}
    extern public var editableAttributes(default, null): Array<String>;
    extern public var id(default, null): ContentId;
    extern public var name(default, null): String;
    extern public var type(default, null): EitherType<String, ContentType>;
    extern public var mimeType(default, null): String;
    extern public var contentURI(default, null): String;
    extern public var thumbnailURIs(default, null): Array<String>;
    extern public var releaseDate(default, null): Date;
    extern public var modifiedDate(default, null): Date;
    extern public var size(default, null): Int64;
    extern public var description(default, null): String;
    extern public var rating(default, null): Int64;
    extern public var isFavorite(default, null): Bool;
}

class VideoContent extends Content {
    public function VideoContent() {}
    extern public var geolocation(default, null): SimpleCoordinates;
    extern public var album(default, null): String;
    extern public var artists(default, null): Array<String>;
    extern public var duration(default, null): Int64;
    extern public var width(default, null): Int64;
    extern public var height(default, null): Int64;
}

typedef AudioContentLyrics = {
    var type: EitherType<String, AudioContentLyricsType>;
    var timestamps: Array<Int64>;
    var texts: Array<String>;
}

class AudioContent extends Content {
    public function AudioContent() {}
    extern public var album(default, null): String;
    extern public var genres(default, null): Array<String>;
    extern public var artists(default, null): Array<String>;
    extern public var composers(default, null): Array<String>;
    extern public var lyrics(default, null): AudioContentLyrics;
    extern public var copyright(default, null): String;
    extern public var bitrate(default, null): Int64;
    extern public var trackNumber(default, null): Int64;
    extern public var duration(default, null): Int64;
}

class ImageContent extends Content {
    public function ImageContent() {}
    extern public var geolocation(default, null): SimpleCoordinates;
    extern public var width(default, null): Int64;
    extern public var height(default, null): Int64;
    extern public var orientation(default, null): EitherType<String, ImageContentOrientation>;
}

typedef PlaylistItem = {
   var content: Content;
}

class Playlist {
    public function new() {}
    extern public var id(default, null): PlaylistId;
    extern public var name(default, null): String;
    extern public var numberOfTracks(default, null): Int64;
    extern public var thumbnailURI(default, null): String;
    extern public function add(item: Content): Void;
    extern public function addBatch(items: Array<Content>, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function remove(item: PlaylistItem): Void;
    extern public function removeBatch(items: Array<PlaylistItem>, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function get(successCallback: TizenCallback, ?errorCallback: TizenCallback, ?count: Int64, ?offset: Int64): Void;
    extern public function setOrder(items: Array<PlaylistItem>, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function move(item: PlaylistItem, delta: Int64, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

typedef DownloadHTTPHeaderFields = Dynamic;

@:enum abstract DownloadState(String) {
    var QUEUED;
    var DOWNLOADING;
    var PAUSED;
    var CANCELED;
    var COMPLETED;
    var FAILED;
    var ABANDONED;
}

@:enum abstract DownloadNetworkType(String) {
    var CELLULAR;
    var WIFI;
    var ALL;
}

@:native("tizen.DownloadRequest")
extern class DownloadRequest {
    public function new(url: String, ?destination: String, ?fileName: String, ?networkType: EitherType<String, DownloadNetworkType>, ?httpHeader: DownloadHTTPHeaderFields);
    extern public var url(default, null): String;
    extern public var destination(default, null): String;
    extern public var fileName(default, null): String;
    extern public var networkType(default, null): EitherType<String, DownloadNetworkType>;
    extern public var httpHeader(default, null): EitherType<String, DownloadHTTPHeaderFields>;
}

class DownloadManager {
    public function new() {}
    extern public function start(downloadRequest: DownloadRequest, ?downloadCallback: DownloadCallback): Int64;
    extern public function cancel(downloadId: Int64): Void;
    extern public function pause(downloadId: Int64): Void;
    extern public function abandon(downloadId: Int64): Void;
    extern public function resume(downloadId: Int64): Void;
    extern public function getState(downloadId: Int64): EitherType<String, DownloadState>;
    extern public function getDownloadRequest(downloadId: Int64): DownloadRequest;
    extern public function getMIMEType(downloadId: Int64): String;
    extern public function setListener(downloadId: Int64, downloadCallback: DownloadCallback): Void;
}

typedef DownloadCallback = {
    var onprogress: TizenCallback;
    var onpaused: TizenCallback;
    var oncanceled: TizenCallback;
    var oncompleted: TizenCallback;
    var onfailed: TizenCallback;
}

@:enum abstract LatencyMode(String) {
    var LOW;
    var MID;
    var HIGH;
}

class PlayerUtilManager {
    public function new() {}
    extern public function getLatencyMode(): EitherType<String, LatencyMode>;
    extern public function setLatencyMode(mode: EitherType<String, LatencyMode>);
}

@:enum abstract MetadataType(String) {
    var ALBUM;
    var ALBUM_ARTIST;
    var ALTITUDE;
    var AUDIO_BITPERSAMPLE;
    var AUDIO_BITRATE;
    var AUDIO_CHANNELS;
    var AUDIO_CODEC;
    var AUDIO_SAMPLERATE;
    var CLASSIFICATION;
    var COMMENT;
    var COMPOSER;
    var CONDUCTOR;
    var COPYRIGHT;
    var DATE;
    var DESCRIPTION;
    var DURATION;
    var GENRE;
    var HAS_AUDIO;
    var HAS_VIDEO;
    var LATITUDE;
    var LONGITUDE;
    var MODE_360;
    var RATING;
    var RECDATE;
    var ROTATE;
    var SYNCLYRICS_NUM;
    var TITLE;
    var TRACK_NUM;
    var UNSYNCLYRICS;
    var VIDEO_BITRATE;
    var VIDEO_CODEC;
    var VIDEO_FPS;
    var VIDEO_HEIGHT;
    var VIDEO_WIDTH;
}

class MetadataManager {
    public function new() {}
    extern public function createFileHandle(path: Path): MetadataFileHandle;
}

class MetadataFileHandle {
    public function new() {}
    extern public var uri(default, null): String;
    extern public function get(type: EitherType<String, MetadataType>): String;
    extern public function release(): Void;
}

@:enum abstract NetworkType(String) {
    var CELLULAR;
    var UNKNOWN;
}

class NetworkBearerSelection {
    public function new() {}
    extern public function requestRouteToHost(networkType: EitherType<String, NetworkType>, domainName: String, successCallback: NetworkSuccessCallback, ?errorCallback: TizenCallback): Void;
    extern public function releaseRouteToHost(networkType: EitherType<String, NetworkType>, domainName: String, successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

typedef NetworkSuccessCallback = {
    var onsuccess: TizenCallback;
    var ondisconnected: TizenCallback;
}

class WebSettingManager {
    public function new() {}
    extern public function setUserAgentString(userAgent: String, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function removeAllCookies(?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

@:enum abstract PowerResource(String) {
    var SCREEN;
    var CPU;
}

@:enum abstract PowerScreenState(String) {
    var SCREEN_OFF;
    var SCREEN_DIM;
    var SCREEN_NORMAL;
}

@:enum abstract PowerCpuState(String) {
    var CPU_AWAKE;
}

typedef PowerState = EitherType<PowerScreenState, PowerCpuState>;

class PowerManager {
    public function new() {}
    extern public function request(resource: EitherType<String, PowerResource>, state: EitherType<String, PowerState>): Void;
    extern public function release(resource: EitherType<String, PowerResource>): Void;
    extern public function setScreenStateChangeListener(listener: TizenCallback): Void;
    extern public function unsetScreenStateChangeListener(): Void;
    extern public function getScreenBrightness(): Float;
    extern public function setScreenBrightness(brightness: Float): Void;
    extern public function isScreenOn(): Bool;
    extern public function restoreScreenBrightness(): Void;
}

@:enum abstract FeedbackType(String) {
    var TYPE_SOUND;
    var TYPE_VIBRATION;
}

@:enum abstract FeedbackPattern(String) {
    var TAP;
    var SIP;
    var KEY0;
    var KEY1;
    var KEY2;
    var KEY3;
    var KEY4;
    var KEY5;
    var KEY6;
    var KEY7;
    var KEY8;
    var KEY9;
    var KEY_STAR;
    var KEY_SHARP;
    var KEY_BACK;
    var HOLD;
    var HW_TAP;
    var HW_HOLD;
    var MESSAGE;
    var EMAIL;
    var WAKEUP;
    var SCHEDULE;
    var TIMER;
    var GENERAL;
    var POWERON;
    var POWEROFF;
    var CHARGERCONN;
    var CHARGING_ERROR;
    var FULLCHARGED;
    var LOWBATT;
    var LOCK;
    var UNLOCK;
    var VIBRATION_ON;
    var SILENT_OFF;
    var BT_CONNECTED;
    var BT_DISCONNECTED;
    var LIST_REORDER;
    var LIST_SLIDER;
    var VOLUME_KEY;
}

class FeedbackManager {
    public function new() {}
    extern public function play(pattern: EitherType<String, FeedbackPattern>, ?type: EitherType<String, FeedbackType>): Void;
    extern public function stop(): Void;
    extern public function isPatternSupported(pattern: EitherType<String, FeedbackPattern>, type: EitherType<String, FeedbackType>): Bool;
}

typedef PushRegistrationId = String;

@:enum abstract PushRegistrationState(String) {
    var REGISTERED;
    var UNREGISTERED;
}

class PushManager {
    public function new() {}
    extern public function register(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function unregister(?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function connect(stateChangeCallback: TizenCallback, notificationCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function disconnect(): Void;
    extern public function getRegistrationId(): PushRegistrationId;
    extern public function getUnreadNotifications(): Void;
    extern public function getPushMessage(): PushMessage;
}

typedef PushMessage = {
    var appData: String;
    var alertMessage: String;
    var message: String;
    var date: Date;
    var sender: String;
    var sessionInfo: String;
    var requestId: String;
}

@:enum abstract SystemSettingType(String) {
    var HOME_SCREEN;
    var LOCK_SCREEN;
    var INCOMING_CALL;
    var NOTIFICATION_EMAIL;
}

class SystemSettingManager {
    public function new() {}
    extern public function setProperty(type: EitherType<String, SystemSettingType>, value: String, successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function getProperty(type: EitherType<String, SystemSettingType>, successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

@:enum abstract MediaKeyType(String) { 
    var MEDIA_PLAY;
    var MEDIA_STOP;
    var MEDIA_PAUSE;
    var MEDIA_PREVIOUS;
    var MEDIA_NEXT;
    var MEDIA_FAST_FORWARD;
    var MEDIA_REWIND;
}

class MediaKeyManager {
    public function new() {}
    extern public function setMediaKeyEventListener(callback: MediaKeyEventCallback): Void;
    extern public function unsetMediaKeyEventListener(): Void;
}

typedef MediaKeyEventCallback = {
    var onpressed: TizenCallback;
    var onreleased: TizenCallback;
}

typedef RawData = String;

@:enum abstract PermissionType(String) {
    var NONE;
    var READ;
    var REMOVE;
    var READ_REMOVE;
    var PPM_ALLOW;
    var PPM_DENY;
    var PPM_ASK;
}

typedef KeyManagerAlias = {
    var packageId: PackageId;
    var name: String;
    var isProtected: Bool;
}

class KeyManager {
    public function new() {}
    extern public function saveData(name: String, rawData: RawData, ?password: String, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function removeData(dataAlias: KeyManagerAlias): Void;
    extern public function getData(dataAlias: KeyManagerAlias, ?password: String): RawData;
    extern public function getDataAliasList(): Array<KeyManagerAlias>;
    extern public function setPermission(dataAlias: KeyManagerAlias, packageId: PackageId, permissionType: EitherType<String, PermissionType>, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

@:enum abstract PermissionRequestResult(String) {
    var PPM_ALLOW_FOREVER;
    var PPM_DENY_FOREVER;
    var PPM_ASK;
}

typedef PrivilegeStatus = {
    var privilege: String;
    var type: EitherType<String, PermissionType>;
}

typedef RequestStatus = {
    var privilege: String;
    var result: EitherType<String, PermissionRequestResult>;
}

class PrivacyPrivilegeManager {
    public function new() {}
    extern public function checkPermission(privilege: String): EitherType<String, PermissionType>;
    extern public function checkPermissions(privileges: Array<String>): EitherType<Array<String>, Array<PrivilegeStatus>>;
    extern public function requestPermission(privilege: String, successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function requestPermissions(privileges: Array<String>, successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

@:enum abstract VoiceControlResultEvent(String) {
    var SUCCESS;
    var FAILURE;
}

@:enum abstract VoiceControlCommandType(String) {
    var FOREGROUND;
}

class VoiceControlClientManager {
    public function new() {}
    extern public function getVoiceControlClient(): VoiceControlClient;
}

class VoiceControlClient {
    public function new() {}
    extern public function getCurrentLanguage(): String;
    extern public function setCommandList(list: Array<EitherType<String, VoiceControlCommand>>, ?type: EitherType<String, VoiceControlCommandType>): Void;
    extern public function unsetCommandList(?type: EitherType<String, VoiceControlCommandType>): Void;
    extern public function addResultListener(listener: TizenCallback): Int64;
    extern public function removeResultListener(id: Int64): Void;
    extern public function addLanguageChangeListener(listener: TizenCallback): Int64;
    extern public function removeLanguageChangeListener(id: Int64): Void;
    extern public function release(): Void;
}

typedef VoiceControlCommand = {
    var command: String;
    var type: EitherType<String, VoiceControlCommandType>;
}

typedef RemoteParty = {
    var ?remoteParty: String;
    var ?personId: PersonId;
}

typedef CallHistoryEntry = {
    var uid: String;
    var type: String;
    var ?features: Array<String>;
    var remoteParties: Array<RemoteParty>;
    var startTime: Date;
    var duration: Int64;
    var direction: String;
    var ?callingParty: String;
}

typedef CallHistoryChangeCallback = {
    var onadded: TizenCallback;
    var onchanged: TizenCallback;
    var onremoved: TizenCallback;
}

class CallHistory {
    public function new() {}
    extern public function find(successCallback: TizenCallback, ?errorCallback: TizenCallback, ?filter: AbstractFilter, ?sortMode: SortMode, ?limit: Int64, ?offset: Int64): Void;
    extern public function remove(entry: CallHistoryEntry): Void;
    extern public function removeBatch(entries: Array<CallHistoryEntry>, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function removeAll(?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function addChangeListener(observer: CallHistoryChangeCallback): Int64;
    extern public function removeChangeListener(handle: Int64): Void;
}

typedef SEChangeListener = {
    var onSEReady: TizenCallback;
    var onSENotReady: TizenCallback;
    var onSEError: TizenCallback;
}

class SEService {
    public function new() {}
    extern public function getReaders(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function registerSEListener(listener: SEChangeListener): Int64;
    extern public function unregisterSEListener(id: Int64): Void;
    extern public function shutdown(): Void;
}

class Reader {
    public function new() {}
    extern public var isPresent(default, null): Bool;
    extern public function getName(): String;
    extern public function openSession(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function closeSessions(): Void;
}

class Session {
    public function new() {}
    extern public var isClosed(default, null): Bool;
    extern public function openBasicChannel(aid: UInt8Array, successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function openLogicalChannel(aid: UInt8Array, successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function getATR(): UInt8Array;
    extern public function close(): Void;
    extern public function closeChannels(): Void;
}

class Channel {
    public function new() {}
    extern public var isBasicChannel(default, null): Bool;
    extern public function close(): Void;
    extern public function transmit(command: UInt8Array, successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function getSelectResponse(): UInt8Array;
}

typedef SyncProfileId = String;

@:enum abstract SyncMode(String) {
    var MANUAL;
    var PERIODIC;
    var PUSH;
}

@:enum abstract SyncType(String) {
    var TWO_WAY;
    var SLOW;
    var ONE_WAY_FROM_CLIENT;
    var REFRESH_FROM_CLIENT;
    var ONE_WAY_FROM_SERVER;
    var REFRESH_FROM_SERVER;
}

@:enum abstract SyncInterval(String) {
    var INTERVAL_5_MINUTES = "5_MINUTES";
    var INTERVAL_15_MINUTES = "15_MINUTES";
    var INTERVAL_HOUR = "1_HOUR";
    var INTERVAL_4_HOURS = "4_HOUR";
    var INTERVAL_12_HOURS = "12_HOUR";
    var INTERVAL_DAY = "1_DAY";
    var INTERVAL_WEEK = "1_WEEK";
    var INTERVAL_MONTH = "1_MONTH";
}

@:enum abstract SyncServiceType(String) {
    var CONTACT;
    var EVENT;
}

@:enum abstract SyncStatus(String) {
    var SUCCESS;
    var FAIL;
    var STOP;
    var NONE;
}

@:native("tizen.SyncInfo")
extern class SyncInfo {
    extern public function new(url: String, id: String, password: String, mode_or_interval: EitherType<EitherType<String, SyncType>, EitherType<String, SyncInterval>>);
    extern public var url(default, null): String;
    extern public var id(default, null): String;
    extern public var password(default, null): String;
    extern public var mode(default, null): EitherType<String, SyncMode>;
    extern public var type(default, null): EitherType<String, SyncType>;
    extern public var interval(default, null): EitherType<String, SyncInterval>;
}

@:native("tizen.SyncServiceInfo")
extern class SyncServiceInfo {
    extern public function new(enable: Bool, serviceType: SyncServiceType, serverDatabaseUri: String, ?id: String, ?password: String);
    extern public var enable(default, null): Bool;
    extern public var serviceType(default, null): EitherType<String, SyncServiceType>;
    extern public var serverDatabaseUri(default, null): String;
    extern public var id(default, null): String;
    extern public var password(default, null): String;
}

@:native("tizen.SyncProfileInfo")
extern class SyncProfileInfo {
    extern public function new(profileName: String, syncInfo: SyncInfo, ?serviceInfo: Array<SyncServiceInfo>);
    extern public var profileId(default, null): SyncProfileId;
    extern public var profileName(default, null): String;
    extern public var syncInfo(default, null): SyncInfo;
    extern public var serviceInfo(default, null): Array<SyncServiceInfo>;
}

typedef SyncStatistics = {
    var syncStatus: SyncStatus;
    var serviceType: SyncServiceType;
    var lastSyncTime: Date;
    var serverToClientTotal: Int64;
    var serverToClientAdded: Int64;
    var serverToClientUpdated: Int64;
    var serverToClientRemoved: Int64;
    var clientToServerTotal: Int64;
    var clientToServerAdded: Int64;
    var clientToServerUpdated: Int64;
    var clientToServerRemoved: Int64;
}

class DataSynchronizationManager {
    public function new() {}
    extern public function add(profile: SyncProfileInfo): Void;
    extern public function update(profile: SyncProfileInfo): Void;
    extern public function remove(profileId: SyncProfileId): Void;
    extern public function getMaxProfilesNum(): Int64;
    extern public function getProfilesNum(): Int64;
    extern public function get(profileId: SyncProfileId): SyncProfileInfo;
    extern public function getAll(): Array<SyncProfileInfo>;
    extern public function startSync(profileId: SyncProfileId, ?progressCallback: SyncProgressCallback): Void;
    extern public function stopSync(profileId: SyncProfileId): Void;
}

typedef SyncProgressCallback = {
    var onprogress: TizenCallback;
    var oncompleted: TizenCallback;
    var onstopped: TizenCallback;
    var onfailed: TizenCallback;
}

final window: JSGlobal = js.Lib.global;
final navigator: JSNavigator = cast js.Browser.window.navigator;//js.Lib.global.navigator;

/** global object **/
extern class JSGlobal extends js.html.Window {
	public var device: Device;
    public var cordova: Cordova;
    public var TEMPORARY: Int;
    public var PERSISTENT: Int;
    public function requestFileSystem(type: Int, size: Int64, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    public function resolveLocalFileSystemURL(uri: String, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

extern class JSNavigator extends js.html.Navigator {
    var connection: NetworkInformationManager;
    var notification: DialogsManager;
    var accelerometer: Accelerometer;
    var globalization: GlobalizationManager;
}

@:native("window.cordova")
extern class Cordova {
    public function new();
    extern public var file: CordovaFileSystemManager;
}

typedef WriteData = EitherType<Blob, String>;
typedef ReadResultData = EitherType<String, UInt8Array>;

typedef FilePropertyBag = {
    var type: String;
    var lastModified: Int64;
}

typedef ProgressEventInit = {
    var loaded: Int64;
    var total: Int64;
    var target: js.html.EventTarget;
}

@:native("window.ProgressEvent")
extern class ProgressEvent {
    public function new(type: String, ?eventInitDict: ProgressEventInit);
    extern public var type(default, null): String;
    extern public var bubbles(default, null): Bool;
    extern public var cancelBubble(default, null): Bool;
    extern public var cancelable(default, null): Bool;
    extern public var lengthComputable(default, null): Bool;
    extern public var loaded(default, null): Int64;
    extern public var total(default, null): Int64;
    extern public var target(default, null): js.html.EventTarget;
}

typedef CordovaFileSystemManager = {
    var applicationDirectory: String;
    var applicationStorageDirectory: String;
    var dataDirectory: String;
    var cacheDirectory: String;
    var externalApplicationStorageDirectory: String;
    var externalDataDirectory: String;
    var externalCacheDirectory: String;
    var externalRootDirectory: String;
    var tempDirectory: String;
    var syncedDataDirectory: String;
    var documentsDirectory: String;
    var sharedDirectory: String;
}

typedef FileSystem = {
    var name: String;
    var root: DirectoryEntry;
}

typedef Metadata = {
    var modificationTime: Date;
    var size: Int64;
}

class FileError {
    public function new() {}
    extern public var NOT_FOUND_ERR(default, null): Int;
    extern public var SECURITY_ERR(default, null): Int;
    extern public var ABORT_ERR(default, null): Int;
    extern public var NOT_READABLE_ERR(default, null): Int;
    extern public var ENCODING_ERR(default, null): Int;
    extern public var NO_MODIFICATION_ALLOWED_ERR(default, null): Int;
    extern public var INVALID_STATE_ERR(default, null): Int;
    extern public var SYNTAX_ERR(default, null): Int;
    extern public var INVALID_MODIFICATION_ERR(default, null): Int;
    extern public var QUOTA_EXCEEDED_ERR(default, null): Int;
    extern public var TYPE_MISMATCH_ERR(default, null): Int;
    extern public var PATH_EXISTS_ERR(default, null): Int;
    extern public var code(default, null): Int;
}

typedef File = {
    var name: String;
    var localURL: String;
    var type: String;
    var lastModified: Date;
    var size: Int64;
}

class Entry {
    public function new() {}
    extern public var isFile(default, null): Bool;
    extern public var isDirectory(default, null): Bool;
    extern public var fullPath(default, null): String;
    extern public var name(default, null): String;
    extern public var filesystem(default, null): FileSystem;
    extern public function getMetadata(onsuccess: TizenCallback, ?onerror: TizenCallback): Void;
    extern public function moveTo(parent: DirectoryEntry, ?newName: String, ?onsuccess: TizenCallback, ?onerror: TizenCallback): Void;
    extern public function copyTo(parent: DirectoryEntry, ?newName: String, ?onsuccess: TizenCallback, ?onerror: TizenCallback): Void;
    extern public function getParent(onsuccess: TizenCallback, ?onerror: TizenCallback): Void;
    extern public function remove(onsuccess: TizenCallback, ?onerror: TizenCallback): Void;
    extern public function toURL(): String;
}

class DirectoryEntry extends Entry {
    extern public function new();
    extern public function createReader(): DirectoryReader;
    extern public function getDirectory(path: String, ?options: Dynamic, ?onsuccess: TizenCallback, ?onerror: TizenCallback): Void;
    extern public function getFile(path: String, ?options: Dynamic, ?onsuccess: TizenCallback, ?onerror: TizenCallback): Void;
    extern public function removeRecursively(onsuccess: TizenCallback, ?onerror: TizenCallback): Void;
}

class DirectoryReader {
    public function new() {}
    extern public function readEntries(onsuccess: TizenCallback, ?onerror: TizenCallback): Void;
}

class FileEntry extends Entry {
    extern public function new();
    extern public function createWriter(onsuccess: TizenCallback, ?onerror: TizenCallback): Void;
    extern public function file(onsuccess: TizenCallback, ?onerror: TizenCallback): Void;
}

@:native("window.FileReader")
extern class FileReader {
    public function new();
    extern public var EMPTY(default, null): Int;
    extern public var LOADING(default, null): Int;
    extern public var DONE(default, null): Int;
    extern public var readyState(default, null): Int;
    extern public var result(default, null): ReadResultData;
    extern public var error(default, null): FileError;
    extern public var onloadStart(default, null): TizenCallback;
    extern public var onload(default, null): TizenCallback;
    extern public var onabort(default, null): TizenCallback;
    extern public var onerror(default, null): TizenCallback;
    extern public var onloadend(default, null): TizenCallback;
    extern public function abort(): Void;
    extern public function readAsDataURL(blob: Blob): Void;
    extern public function readAsText(blob: Blob, ?label: String): Void;
    extern public function readAsBinaryString(blob: Blob): Void;
    extern public function readAsArrayBuffer(blob: Blob): Void;
}

class FileWriter {
    public function new() {}
    extern public var INIT(default, null): Int;
    extern public var WRITING(default, null): Int;
    extern public var DONE(default, null): Int;
    extern public var readyState(default, null): Int;
    extern public var fileName(default, null): String;
    extern public var length(default, null): Int64;
    extern public var position(default, null): Int64;
    extern public var error(default, null): FileError;
    extern public var onwritestart(default, null): TizenCallback;
    extern public var onwrite(default, null): TizenCallback;
    extern public var onabort(default, null): TizenCallback;
    extern public var onerror(default, null): TizenCallback;
    extern public var onwriteend(default, null): TizenCallback;
    extern public function abort(): Void;
    extern public function seek(offset: Int64): Void;
    extern public function truncate(size: Int64): Void;
    extern public function write(data: WriteData): Void;
}
  
typedef FileUploadParams = Dynamic;
typedef HeaderFields = Dynamic;
typedef FileDownloadOptions = Dynamic;

typedef FileUploadResult = {
    var bytesSent: Int64;
    var responseCode: Int64;
    var response: String;
    var headers: HeaderFields;
}

@:native("window.FileUploadOptions")
extern class FileUploadOptions {
    public function new();
    extern public var onprogress(default, null): TizenCallback;
    extern public function upload(fileURL: String, server: String, ?successCallback: TizenCallback, ?errorCallback: TizenCallback, ?options: FileUploadOptions, ?trustAllHosts: Bool): Void;
    extern public function download(fileURL: String, server: String, ?successCallback: TizenCallback, ?errorCallback: TizenCallback, ?trustAllHosts: Bool, ?options: FileDownloadOptions): Void;
    extern public function abort(): Void;
}

@:native("window.FileTransfer")
extern class FileTransfer {
    public function new(fileKey: String, fileName: String, mimeType: String, params: FileUploadParams, headers: HeaderFields, httpMethod: String);
    extern public var fileKey(default, null): String;
    extern public var fileName(default, null): String;
    extern public var httpMethod(default, null): String;
    extern public var mimeType(default, null): String;
    extern public var params(default, null): FileUploadParams;
    extern public var chunkedMode(default, null): Bool;
    extern public var headers(default, null): HeaderFields;
}

class FileTransferError {
    public function new() {}
    extern public static var FILE_NOT_FOUND_ERR(default, null): Int;
    extern public static var INVALID_URL_ERR(default, null): Int;
    extern public static var CONNECTION_ERR(default, null): Int;
    extern public static var ABORT_ERR(default, null): Int;
    extern public static var NOT_MODIFIED_ERR(default, null): Int;
    extern public var code(default, null): Int;
    extern public var source(default, null): String;
    extern public var target(default, null): String;
    extern public var http_status(default, null): Int64;
    extern public var body(default, null): String;
    extern public var _exception(default, null): String;
}

typedef DateOptions = {
    var formatLength: String;
    var selector: String;
}

typedef CurrencyPattern = {
    var pattern: String;
    var code: String;
    var fraction: Int64;
    var rounding: Float;
    var decimal: String;
    var grouping: String;
}

typedef GetDateNamesOptions = {
    var type: String;
    var item: String;
}

typedef NumberPatternOptions = {
    var type: String;
}

typedef DatePattern = {
    var pattern: String;
    var timezone: String;
    var utc_offset: Int64;
    var dst_offset: Int64;
}

typedef NumberPattern = {
    var pattern: String;
    var symbol: String;
    var fraction: Int64;
    var rounding: Float;
    var positive: String;
    var negative: String;
    var decimal: String;
    var grouping: String;
}

typedef GlobalizationDate = {
    var year: Int64;
    var month: Int64;
    var day: Int64;
    var hour: Int64;
    var minute: Int64;
    var second: Int64;
    var millisecond: Int64;
}

@:native("window.navigator.globalization")
extern class GlobalizationManager {
    public function new();
    extern public function getPreferredLanguage(onsuccess: TizenCallback, onerror: TizenCallback): Void;
    extern public function getLocaleName(onsuccess: TizenCallback, onerror: TizenCallback): Void;
    extern public function dateToString(date: Date, onsuccess: TizenCallback, onerror: TizenCallback, ?options: DateOptions): Void;
    extern public function getCurrencyPattern(currencyCode: String, onsuccess: TizenCallback, onerror: TizenCallback): Void;
    extern public function getDateNames(onsuccess: TizenCallback, onerror: TizenCallback, ?options: GetDateNamesOptions): Void;
    extern public function getDatePattern(onsuccess: TizenCallback, onerror: TizenCallback, ?options: GetDateNamesOptions): Void;
    extern public function getFirstDayOfWeek(onsuccess: TizenCallback, onerror: TizenCallback): Void;
    extern public function getNumberPattern(onsuccess: TizenCallback, onerror: TizenCallback, ?options: NumberPatternOptions): Void;
    extern public function isDayLightSavingsTime(date: Date, onsuccess: TizenCallback, onerror: TizenCallback): Void;
    extern public function numberToString(number: Float, onsuccess: TizenCallback, onerror: TizenCallback, ?options: NumberPatternOptions): Void;
    extern public function stringToDate(dateString: String, onsuccess: TizenCallback, onerror: TizenCallback, ?options: DateOptions): Void;
    extern public function stringToNumber(numberString: String, onsuccess: TizenCallback, onerror: TizenCallback, ?options: NumberPatternOptions): Void;
}

class GlobalizationError {
    public function new() {}
    extern public static var UNKNOWN_ERROR(default, null): Int;
    extern public static var FORMATTING_ERROR(default, null): Int;
    extern public static var PARSING_ERROR(default, null): Int;
    extern public static var PATTERN_ERROR(default, null): Int;
    extern public var code(default, null): Int;
    extern public var message(default, null): String;
}

@:native("window.navigator.Accelerometer")
extern class Accelerometer {
    public function new();
    extern public function getCurrentAcceleration(onsuccess: TizenCallback, onerror: TizenCallback): Void;
    extern public function watchAcceleration(onsuccess: TizenCallback, onerror: TizenCallback, ?options: AccelerationOptions): String;
    extern public function clearWatch(watchID: String): Void;
}

typedef AccelerationOptions = {
    var frequency: Int64;
}

typedef Acceleration = {
    var x: Float;
    var y: Float;
    var z: Float;
    var timestamp: Int64;
}

@:native("Media")
extern class Media {
    public function new(src: String, ?successCallback: TizenCallback, ?errorCallback: TizenCallback, ?mediaStatus: TizenCallback);
    extern public static var MEDIA_NONE(default, null): Int;
    extern public static var MEDIA_STARTING(default, null): Int;
    extern public static var MEDIA_RUNNING(default, null): Int;
    extern public static var MEDIA_PAUSED(default, null): Int;
    extern public static var MEDIA_STOPPED(default, null): Int;
    extern public var src(default, null): String;
    extern public var successCallback(default, null): TizenCallback;
    extern public var errorCallback(default, null): TizenCallback;
    extern public var statusCallback(default, null): TizenCallback;
    extern public function getCurrentPosition(positionSuccessCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function getDuration(): Float;
    extern public function pause(): Void;
    extern public function play(): Void;
    extern public function release(): Void;
    extern public function seekTo(position: Float): Void;
    extern public function setVolume(volume: Float): Void;
    extern public function startRecord(): Void;
    extern public function stopRecord(): Void;
    extern public function stop(): Void;
}

class MediaError {
    public function new() {}
    extern public static var MEDIA_ERR_ABORTED(default, null): Int;
    extern public static var MEDIA_ERR_NETWORK(default, null): Int;
    extern public static var MEDIA_ERR_DECODE(default, null): Int;
    extern public static var MEDIA_ERR_NONE_SUPPORTED(default, null): Int;
    extern public var code(default, null): Int;
}

@:native("window.navigator.notification")
extern class DialogsManager {
    public function new();
    extern public function alert(message: String, alertCallback: TizenCallback, ?title: String, ?buttonName: String): Void;
    extern public function confirm(message: String, confirmCallback: TizenCallback, ?title: String, ?buttonNames: Array<String>): Void;
    extern public function prompt(message: String, promptCallback: TizenCallback, ?title: String, ?buttonNames: Array<String>, ?defaultText: String): Void;
    extern public function beep(times: Int64): Void;
}

typedef PromptData = {
    var buttonIndex: Int64;
    var input1: String;
}

@:native("window.navigator.connection")
extern class NetworkInformationManager {
    public function new();
    extern public var type(default, null): String;
}

@:native("window.Connection")
extern class Connection {
    public function new();
    extern public static var UNKNOWN(default, null): String;
    extern public static var ETHERNET(default, null): String;
    extern public static var WIFI(default, null): String;
    extern public static var CELL_2G(default, null): String;
    extern public static var CELL_3G(default, null): String;
    extern public static var CELL_4G(default, null): String;
    extern public static var CELL(default, null): String;
    extern public static var NONE(default, null): String;
}

@:native("window.cordova.device")
extern class Device {
    // window.cordova.device
    public function new();
    extern public var cordova(default, null): String;
    extern public var model(default, null): String;
    extern public var platform(default, null): String;
    extern public var uuid(default, null): String;
    extern public var version(default, null): String;
}

class DOMException {
    public function new() {}
    extern public var code(default, null): Int;
    extern public var name(default, null): String;
    extern public var message(default, null): String;
}

@:enum abstract AudioOutputMode(String) {
    var PCM;
    var DOLBY;
    var DTS;
    var AAC;
    var DOLBY_DIGITAL_PLUS;
}

@:enum abstract AudioBeepType(String) {
    var UP;
    var DOWN;
    var LEFT;
    var RIGHT;
    var PAGE_LEFT;
    var PAGE_RIGHT;
    var BACK;
    var SELECT;
    var CANCEL;
    var WARNING;
    var KEYPAD;
    var KEYPAD_ENTER;
    var KEYPAD_DEL;
    var MOVE;
    var PREPARING;
}

class AudioControlManager {
    public function new() {}
    extern public function setMute(mute: Bool): Void;
    extern public function isMute(): Bool;
    extern public function setVolume(volume: Int): Void;
    extern public function setVolumeUp(): Void;
    extern public function setVolumeDown(): Void;
    extern public function getVolume(): Int;
    extern public function setVolumeChangeListener(callback: TizenCallback): Void;
    extern public function unsetVolumeChangeListener(): Void;
    extern public function getOutputMode(): EitherType<String, AudioOutputMode>;
    extern public function playSound(type: EitherType<String, AudioBeepType>): Void;
}

@:enum abstract Display3DEffectMode(String) {
    var OFF;
    var TOP_BOTTOM;
    var SIDE_BY_SIDE;
    var LINE_BY_LINE;
    var VERTICAL_STRIPE;
    var FRAME_SEQUENCE;
    var CHECKER_BD;
    var FROM_2D_TO_3D;
}

@:enum abstract Display3DModeState(String) {
    var NOT_CONNECTED;
    var NOT_SUPPORTED;
    var READY;
}

class DisplayControlManager {
    public function new() {}
    extern public function get3DEffectMode(): EitherType<String, Display3DEffectMode>;
    extern public function is3DModeEnabled(): EitherType<String, Display3DModeState>;
    extern public function getSupported3DEffectModeList(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

@:enum abstract CaptionInfoKey(String) {
    var CAPTION_ONOFF_KEY;
    var CAPTION_MODE_KEY;
    var CAPTION_FONT_SIZE_KEY;
    var CAPTION_FONT_STYLE_KEY;
    var CAPTION_FONT_COLOR_KEY;
    var CAPTION_FONT_OPACITY_KEY;
    var CAPTION_BG_COLOR_KEY;
    var CAPTION_BG_OPACITY_KEY;
    var CAPTION_EDGE_TYPE_KEY;
    var CAPTION_EDGE_COLOR_KEY;
    var CAPTION_WINDOW_COLOR_KEY;
    var CAPTION_WINDOW_OPACITY_KEY;
    var CAPTION_STYLE_KEY;
}

@:enum abstract CaptionState(String) {
    var CAPTION_OFF;
    var CAPTION_ON;
}

@:enum abstract CaptionMode(String) {
    var CAPTION_MODE_DEFAULT;
    var CAPTION_MODE_SERVICE1;
    var CAPTION_MODE_SERVICE2;
    var CAPTION_MODE_SERVICE3;
    var CAPTION_MODE_SERVICE4;
    var CAPTION_MODE_SERVICE5;
    var CAPTION_MODE_SERVICE6;
    var CAPTION_MODE_CC1;
    var CAPTION_MODE_CC2;
    var CAPTION_MODE_CC3;
    var CAPTION_MODE_CC4;
    var CAPTION_MODE_TEXT1;
    var CAPTION_MODE_TEXT2;
    var CAPTION_MODE_TEXT3;
    var CAPTION_MODE_TEXT4;
}

@:enum abstract CaptionFontSize(String) {
    var CAPTION_SIZE_DEFAULT;
    var CAPTION_SIZE_SMALL;
    var CAPTION_SIZE_STANDARD;
    var CAPTION_SIZE_LARGE;
    var CAPTION_SIZE_EXTRA_LARGE;
}

@:enum abstract CaptionFontStyle(String) {
    var CAPTION_FONT_DEFAULT;
    var CAPTION_FONT_STYLE0;
    var CAPTION_FONT_STYLE1;
    var CAPTION_FONT_STYLE2;
    var CAPTION_FONT_STYLE3;
    var CAPTION_FONT_STYLE4;
    var CAPTION_FONT_STYLE5;
    var CAPTION_FONT_STYLE6;
    var CAPTION_FONT_STYLE7;
}

@:enum abstract CaptionColor(String) {
    var CAPTION_COLOR_DEFAULT;
    var CAPTION_COLOR_WHITE;
    var CAPTION_COLOR_BLACK;
    var CAPTION_COLOR_RED;
    var CAPTION_COLOR_GREEN;
    var CAPTION_COLOR_BLUE;
    var CAPTION_COLOR_YELLOW;
    var CAPTION_COLOR_MAGENTA;
    var CAPTION_COLOR_CYAN;
}

@:enum abstract CaptionOpacity(String) {
    var CAPTION_OPACITY_SOLID;
    var CAPTION_OPACITY_FLASHING;
    var CAPTION_OPACITY_TRANSLUCENT;
    var CAPTION_OPACITY_TRANSPARENT;
    var CAPTION_OPACITY_DEFAULT;
}

@:enum abstract CaptionEdge(String) {
    var CAPTION_EDGE_NONE;
    var CAPTION_EDGE_RAISED;
    var CAPTION_EDGE_DEPRESSED;
    var CAPTION_EDGE_UNIFORM;
    var CAPTION_EDGE_DROP_SHADOWED;
}

@:enum abstract CaptionStyle(String) {
    var CAPTION_STYLE_DEFAULT;
    var CAPTION_STYLE_BOLD;
    var CAPTION_STYLE_ITALIC;
}

typedef CaptionValue = EitherType<String, EitherType<EitherType<EitherType<CaptionState, CaptionMode>, EitherType<CaptionFontSize, CaptionFontStyle>>, EitherType<EitherType<CaptionColor, CaptionOpacity>, EitherType<CaptionEdge, CaptionStyle>>>>;

class TVInfoManager {
    public function new() {}
    extern public function getCaptionValue(key: CaptionInfoKey): CaptionValue;
    extern public function addCaptionValueChangeListener(key: CaptionInfoKey, callback: TizenCallback): Int64;
    extern public function removeCaptionValueChangeListener(watchId: Int64): Void;
}

class TVInputDeviceManager {
    public function new() {}
    extern public function getSupportedKeys(): Array<InputDeviceKey>;
    extern public function getKey(keyName: InputDeviceKeyName): InputDeviceKey;
    extern public function registerKey(keyName: InputDeviceKeyName): Void;
    extern public function unregisterKey(keyName: InputDeviceKeyName): Void;
    extern public function registerKeyBatch(keyNames: Array<InputDeviceKeyName>, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function unregisterKeyBatch(keyNames: Array<InputDeviceKeyName>, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

@:enum abstract WindowType(String) {
    var MAIN;
}

@:enum abstract MeasurementUnit(String) {
    var UNIT_PX = "px";
    var UNIX_PERCENTAGE = "%";
}

@:enum abstract PictureSizeType(String) {
    var PICTURE_SIZE_TYPE_16x9;
    var PICTURE_SIZE_TYPE_ZOOM;
    var PICTURE_SIZE_TYPE_CUSTOM;
    var PICTURE_SIZE_TYPE_4x3;
    var PICTURE_SIZE_TYPE_21x9_NORMAL;
    var PICTURE_SIZE_TYPE_21x9_AUTO;
    var PICTURE_SIZE_TYPE_21x9_CAPTION;
    var PICTURE_SIZE_TYPE_ORIGINAL_RATIO;
    var PICTURE_SIZE_TYPE_WSS_4x3;
    var PICTURE_SIZE_TYPE_WSS_16x9;
    var PICTURE_SIZE_TYPE_WSS_ZOOM1;
    var PICTURE_SIZE_TYPE_WSS_ZOOM1_DN;
    var PICTURE_SIZE_TYPE_WSS_ZOOM2;
    var PICTURE_SIZE_TYPE_WSS_WIDEZOOM;
    var PICTURE_SIZE_TYPE_WSS_14x9;
    var PICTURE_SIZE_TYPE_UNKNOWN;
}

@:enum abstract ZPosition(String) {
    var FRONT;
    var BEHIND;
}

class TVWindowManager {
    public function new() {}
    extern public function getAvailableWindows(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function setSource(videoSource: SystemInfoVideoSourceInfo, successCallback: TizenCallback, ?errorCallback: TizenCallback, type: EitherType<String, WindowType>): Void;
    extern public function getSource(?type: WindowType): SystemInfoVideoSourceInfo;
    extern public function show(successCallback: TizenCallback, ?errorCallback: TizenCallback, ?rectangle: String, ?type: WindowType, ?zPosition: ZPosition): Void;
    extern public function hide(successCallback: TizenCallback, ?errorCallback: TizenCallback, ?type: WindowType): Void;
    extern public function getRect(successCallback: TizenCallback, ?errorCallback: TizenCallback, ?unit: EitherType<String, MeasurementUnit>, ?type: WindowType): Void;
    extern public function getVideoResolution(?type: WindowType): VideoResolution;
    extern public function addVideoResolutionChangeListener(callback: TizenCallback, ?type: WindowType): Int64;
    extern public function removeVideoResolutionChangeListener(listenerId: Int64): Void;
}

typedef VideoResolution = {
    var width: Int64;
    var height: Int64;
    var frequency: Int64;
    var pictureSizeType: EitherType<String, PictureSizeType>;
}

@:enum abstract SoundType(String) {
    var SYSTEM;
    var NOTIFICATION;
    var ALARM;
    var MEDIA;
    var VOICE;
    var RINGTONE;
}

@:enum abstract SoundModeType(String) {
    var SOUND;
    var VIBRATE;
    var MUTE;
}

@:enum abstract SoundDeviceType(String) {
    var SPEAKER;
    var RECEIVER;
    var AUDIO_JACK;
    var BLUETOOTH;
    var HDMI;
    var MIRRORING;
    var USB_AUDIO;
    var MIC;
}

@:enum abstract SoundIOType(String) {
    var IN;
    var OUT;
    var BOTH;
}

class SoundManager {
    public function new() {}
    extern public function getSoundMode(): EitherType<String, SoundModeType>;
    extern public function setVolume(type: EitherType<String, SoundType>, volume: Float): Void;
    extern public function getVolume(type: EitherType<String, SoundType>): Float;
    extern public function setSoundModeChangeListener(callback: TizenCallback): Void;
    extern public function unsetSoundModeChangeListener(): Void;
    extern public function setVolumeChangeListener(callback: TizenCallback): Void;
    extern public function unsetVolumeChangeListener(): Void;
    extern public function getConnectedDeviceList(): Array<SoundDeviceInfo>;
    extern public function getActivatedDeviceList(): Array<SoundDeviceInfo>;
    extern public function addDeviceStateChangeListener(callback: TizenCallback): Int64;
    extern public function removeDeviceStateChangeListener(id: Int64): Int64;
}

typedef SoundDeviceInfo = {
    var id: Int64;
    var name: String;
    var device: EitherType<String, SoundDeviceType>;
    var direction: EitherType<String, SoundIOType>;
    var isConnected: Bool;
    var isActivated: Bool;
}

@:enum abstract RadioState(String) {
    var PLAYING;
    var SCANNING;
    var READY;
}

@:enum abstract RadioInterruptReason(String) {
    var RADIO_INTERRUPTED_BY_MEDIA;
    var RADIO_INTERRUPTED_BY_SYSTEM;
    var RADIO_INTERRUPTED_BY_ALARM;
    var RADIO_INTERRUPTED_BY_NOTIFICATION;
    var RADIO_INTERRUPTED_BY_EMERGENCY;
    var RADIO_INTERRUPTED_BY_VOICE_INFORMATION;
    var RADIO_INTERRUPTED_BY_VOICE_RECOGNITION;
    var RADIO_INTERRUPTED_BY_RINGTONE;
    var RADIO_INTERRUPTED_BY_VOIP;
    var RADIO_INTERRUPTED_BY_CALL;
    var RADIO_INTERRUPTED_BY_MEDIA_EXTERNAL_ONLY;
}

class FMRadioManager {
    public function new() {}
    extern public var frequency(default, null): Float;
    extern public var frequencyUpperBound(default, null): Float;
    extern public var frequencyLowerBound(default, null): Float;
    extern public var signalStrength(default, null): Int64;
    extern public var state(default, null): EitherType<String, RadioState>;
    extern public var isAntennaConnected(default, null): Bool;
    extern public var mute(default, null): Bool;
    extern public function start(?frequency: Float): Void;
    extern public function stop(): Void;
    extern public function seekUp(?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function seekDown(?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function scanStart(successCallback: FMRadioScanCallback, ?errorCallback: TizenCallback): Void;
    extern public function scanStop(?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function setFMRadioInterruptedListener(interruptCallback: FMRadioInterruptCallback): Void;
    extern public function unsetFMRadioInterruptedListener(): Void;
    extern public function setAntennaChangeListener(changeCallback: TizenCallback): Void;
    extern public function unsetAntennaChangeListener(): Void;
}

typedef FMRadioInterruptCallback = {
    var oninterrupted: TizenCallback;
    var oninterruptfinished: TizenCallback;
}

typedef FMRadioScanCallback = {
    var onfrequencyfound: TizenCallback;
    var onfinished: TizenCallback;
}

@:enum abstract WhiteBalanceMode(String) {
    var AUTO;
    var MANUAL;
}

@:enum abstract ExposureProgram(String) {
    var NOT_DEFINED;
    var MANUAL;
    var NORMAL;
    var APERTURE_PRIORITY;
    var SHUTTER_PRIORITY;
    var CREATIVE_PROGRAM;
    var ACTION_PROGRAM;
    var PORTAIT_MODE;
    var LANDSCAPE_MODE;
}

typedef ExifInit = {
    var uri: String;
    var width: Int64;
    var height: Int64;
    var deviceMaker: String;
    var deviceModel: String;
    var originalTime: Date;
    var orientation: EitherType<String, ImageContentOrientation>;
    var fNumber: Float;
    var isoSpeedRatings: Array<UInt>;
    var exposureTime: String;
    var exposureProgram: EitherType<String, ExposureProgram>;
    var flash: Bool;
    var focalLength: Float;
    var whiteBalance: EitherType<String, WhiteBalanceMode>;
    var gpsLocation: SimpleCoordinates;
    var gpsAltitude: Float;
    var gpsProcessingMethod: String;
    var gpsTime: Date;
    var userComment: String;
}

class ExifManager {
    public function new() {}
    extern public function getExifInfo(uri: String, successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function saveExifInfo(exifInfo: ExifInformation, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function getThumbnail(uri: String, successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

@:native("tizen.ExifInformation")
extern class ExifInformation {
    public function new(?ExifInitDict: ExifInit);
    extern public var uri(default, null): String;
    extern public var width(default, null): Int64;
    extern public var height(default, null): Int64;
    extern public var deviceMaker(default, null): String;
    extern public var deviceModel(default, null): String;
    extern public var originalTime(default, null): Date;
    extern public var orientation(default, null): ImageContentOrientation;
    extern public var fNumber(default, null): Float;
    extern public var isoSpeedRatings(default, null): Array<UInt>;
    extern public var exposureTime(default, null): String;
    extern public var exposureProgram(default, null): EitherType<String, ExposureProgram>;
    extern public var flash(default, null): Bool;
    extern public var focalLength(default, null): Float;
    extern public var whiteBalance(default, null): EitherType<String, WhiteBalanceMode>;
    extern public var gpsLocation(default, null): SimpleCoordinates;
    extern public var gpsAltitude(default, null): Float;
    extern public var gpsProcessingMethod(default, null): String;
    extern public var gpsTime(default, null): TZDate;
    extern public var userComment(default, null): String;
}

@:enum abstract TimeDurationUnit(String) {
    var MSECS;
    var SECS;
    var MINS;
    var HOURS;
    var DAYS;
}

class TimeUtil {
    public function new() {}
    extern public function getCurrentDateTime(): TZDate;
    extern public function getLocalTimezone(): String;
    extern public function getAvailableTimezones(): Array<String>;
    extern public function getDateFormat(?shortformat: Bool): String;
    extern public function getTimeFormat(): String;
    extern public function isLeapYear(year: Int64): Bool;
    extern public function setDateTimeChangeListener(changeCallback: TizenCallback): Void;
    extern public function unsetDateTimeChangeListener(): Void;
    extern public function setTimezoneChangeListener(changeCallback: TizenCallback): Void;
    extern public function unsetTimezoneChangeListener(): Void;
}

@:native("tizen.TZDate")
extern class TZDate {
    public function new(?datetime_or_year: EitherType<Date, Int64>, ?timezone_or_month: EitherType<String, Int64>, day: Int64, ?hours: Int64, ?minutes: Int64, ?seconds: Int64, ?milliseconds: Int64, ?timezone: String);
    extern public function getDate(): Int64;
    extern public function setDate(date: Int64): Void;
    extern public function getDay(): Int64;
    extern public function getFullYear(): Int64;
    extern public function setFullYear(year: Int64): Void;
    extern public function getHours(): Int64;
    extern public function setHours(hours: Int64): Void;
    extern public function getMilliseconds(): Int64;
    extern public function setMilliseconds(ms: Int64): Int64;
    extern public function getMinutes(): Int64;
    extern public function setMinutes(minutes: Int64): Void;
    extern public function getUTCDate(): Int64;
    extern public function setUTCDate(date: Int64): Void;
    extern public function getUTCDay(): Int64;
    extern public function getUTCFullYear(): Int64;
    extern public function setUTCFullYear(year: Int64): Void;
    extern public function getUTCHours(): Int64;
    extern public function setUTCHours(hours: Int64): Void;
    extern public function getUTCMilliseconds(): Int64;
    extern public function setUTCMilliseconds(ms: Int64): Void;
    extern public function getUTCMinutes(): Int64;
    extern public function setUTCMinutes(minutes: Int64): Void;
    extern public function getUTCMonth(): Int64;
    extern public function setUTCMonth(month: Int64): Void;
    extern public function getUTCSeconds(): Int64;
    extern public function setUTCSeconds(seconds: Int64): Void;
    extern public function getTimezone(): String;
    extern public function toTimezone(tzid: String): TZDate;
    extern public function toLocalTimezone(): TZDate;
    extern public function toUTC(): TZDate;
    extern public function difference(other: TZDate): TimeDuration;
    extern public function equalsTo(other: TZDate): Bool;
    extern public function earlierThan(other: TZDate): Bool;
    extern public function laterThan(other: TZDate): Bool;
    extern public function addDuration(duration: TimeDuration): TZDate;
    extern public function toLocaleDateString(): String;
    extern public function toLocaleTimeString(): String;
    extern public function toLocaleString(): String;
    extern public function toDateString(): String;
    extern public function toTimeString(): String;
    extern public function toString(): String;
    extern public function secondsFromUTC(): Int64;
    extern public function isDST(): Bool;
    extern public function getPreviousDSTTransition(): TZDate;
    extern public function getNextDSTTransition(): TZDate;
}

@:native("tizen.TimeDuration")
extern class TimeDuration {
    public function new(length: Int64, ?unit: EitherType<String, TimeDurationUnit>);
    extern public var length(default, null): Int64;
    extern public var unit(default, null): EitherType<String, TimeDurationUnit>;
    extern public function difference(other: TimeDuration): TimeDuration;
    extern public function equalsTo(other: TimeDuration): Bool;
    extern public function lessThan(other: TimeDuration): Bool;
    extern public function greaterThan(other: TimeDuration): Bool;
}

@:enum abstract TeecLoginMethod(String) {
    var PUBLIC;
    var USER;
    var GROUP;
    var APPLICATION;
}

@:enum abstract TeecValueType(String) {
    var INPUT;
    var OUTPUT;
    var INOUT;
}

@:enum abstract TeecTempMemoryType(String) {
    var INPUT;
    var OUTPUT;
    var INOUT;
}

@:enum abstract TeecRegisteredMemoryType(String) {
    var WHOLE;
    var PARTIAL_INPUT;
    var PARTIAL_OUTPUT;
    var PARTIAL_INOUT;
}

@:enum abstract TeecSharedMemoryFlags(String) {
    var INPUT;
    var OUTPUT;
    var INOUT;
}

typedef TeecUuid = String;
typedef TeecTaskId = Int64;

class LibTeecManager {
    public function new() {}
    extern public function getContext(?name: String): TeecContext;
}

class TeecContext {
    public function new() {}
    extern public function openSession(taUUID: TeecUuid, loginMethod: EitherType<String, TeecLoginMethod>, connectionData: Int64, params: Array<TeecParameter>, successCallback: TizenCallback, ?errorCallback: TizenCallback): TeecTaskId;
    extern public function revokeCommand(id: TeecTaskId): Void;
    extern public function allocateSharedMemory(size: Int64, flags: EitherType<String, TeecSharedMemoryFlags>): TeecSharedMemory;
    extern public function registerSharedMemory(addr: Int64, size: Int64, flags: EitherType<String, TeecSharedMemoryFlags>): TeecSharedMemory;
    extern public function releaseSharedMemory(shm: TeecSharedMemory): Void;
}

class TeecSession {
    public function new() {}
    extern public function close(): Void;
    extern public function invokeCommand(cmd: Int64, params: Array<TeecParameter>, successCallback: TizenCallback, ?errorCallback: TizenCallback): TeecTaskId;
}

class TeecParameter {
    public function new() {}
    extern public var type(default, null): String;
}

class TeecSharedMemory {
    public function new() {}
    extern public function setData(data: UInt8Array, offset: Int64): Void;
    extern public function getData(data: UInt8Array, offset: Int64): Void;
}

@:native("TeecRegisteredMemory")
extern class TeecRegisteredMemory extends TeecParameter {
    extern public function new(memory: TeecSharedMemory, offset: Int64, size: Int64);
    extern public var shm(default, null): TeecSharedMemory;
    extern public var offset(default, null): Int64;
    extern public var size(default, null): Int64;
}

@:native("TeecTempMemory")
extern class TeecTempMemory extends TeecParameter {
    extern public function new(mem: UInt8Array);
    extern public var mem(default, null): UInt8Array;
}

@:native("TeecValue")
extern class TeecValue extends TeecParameter {
    extern public function new(a: Int64, b: Int64);
    extern public var a(default, null): Int64;
    extern public var b(default, null): Int64;
}

typedef MessageId = String;
typedef MessageAttachmentId = String;
typedef MessageConvId = String;
typedef MessageFolderId = String;

@:enum abstract MessageServiceTag(String) {
    var SMS = "messaging.sms";
    var MMS = "messaging.mms";
    var EMAIL = "messaging.email";
}

typedef MessageInit = {
    var subject: String;
    var to: Array<String>;
    var cc: Array<String>;
    var bcc: Array<String>;
    var plainBody: String;
    var htmlBody: String;
    var isHighPriority: Bool;   
}

@:native("tizen.Message")
extern class Message {
    public function new(type: EitherType<String, MessageServiceTag>, ?messageInitDict: MessageInit);
    extern public var id(default, null): MessageId;
    extern public var conversationId(default, null): MessageConvId;
    extern public var folderId(default, null): MessageFolderId;
    extern public var type(default, null): EitherType<String, MessageServiceTag>;
    extern public var timestamp(default, null): Date;
    extern public var from(default, null): String;
    extern public var to(default, null): Array<String>;
    extern public var cc(default, null): Array<String>;
    extern public var bcc(default, null): Array<String>;
    extern public var body(default, null): MessageBody;
    extern public var isRead(default, null): Bool;
    extern public var hasAttachment(default, null): Bool;
    extern public var isHighPriority(default, null): Bool;
    extern public var subject(default, null): String;
    extern public var inResponseTo(default, null): MessageId;
    extern public var messageStatus(default, null): String;
    extern public var attachments(default, null): Array<MessageAttachment>;
}

typedef MessageBody = {
    var messageId: MessageId;
    var loaded: Bool;
    var plainBody: String;
    var htmlBody: String;
    var inlineAttachments: Array<MessageAttachment>;
}

@:native("tizen.MessageAttachment")
extern class MessageAttachment {
    public function new(filePath: String, ?mimeType: String);
    extern public var id(default, null): MessageAttachmentId;
    extern public var messageId(default, null): MessageId;
    extern public var mimeType(default, null): String;
    extern public var filePath(default, null): String;
}

class Messaging {
    public function new() {}
    extern public function getMessageServices(messageServiceType: EitherType<String, MessageServiceTag>, successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

class MessageService {
    public function new() {}
    extern public var id(default, null): String;
    extern public var type(default, null): EitherType<String, MessageServiceTag>;
    extern public var name(default, null): String;
    extern public var messageStorage(default, null): MessageStorage;
    extern public function sendMessage(message: Message, ?successCallback: TizenCallback, ?errorCallback: TizenCallback, ?simIndex: Int64): Void;
    extern public function longMessageBody(message: Message, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function loadMessageAttachment(attachment: MessageAttachment, successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function sync(?successCallback: TizenCallback, ?errorCallback: TizenCallback, ?limit: Int64): Int64;
    extern public function syncFolder(folder: MessageFolder, ?successCallback: TizenCallback, ?errorCallback: TizenCallback, ?limit: Int64): Int64;
    extern public function stopSync(opId: Int64): Void;
}

class MessageStorage {
    public function new() {}
    extern public function addDraftMessage(message: Message, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function findMessages(filter: AbstractFilter, successCallback: TizenCallback, ?errorCallback: TizenCallback, ?sort: SortMode, ?limit: Int64, ?offset: Int64): Void;
    extern public function removeMessages(messages: Array<Message>, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function updateMessages(messages: Array<Message>, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function findConversations(filter: AbstractFilter, successCallback: TizenCallback, ?errorCallback: TizenCallback, ?sort: SortMode, ?limit: Int64, ?offset: Int64): Void;
    extern public function removeConversations(conversations: Array<MessageConversation>, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function findFolders(filter: AbstractFilter, successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function addMessagesChangeListener(messagesChangeCallback: MessagesChangeCallback, ?filter: AbstractFilter): Int64;
    extern public function addConversationsChangeListener(conversationsChangeCallback: MessageConversationsChangeCallback, ?filter: AbstractFilter): Int64;
    extern public function addFoldersChangeListener(foldersChangeCallback: MessageFoldersChangeCallback, ?filter: AbstractFilter): Int64;
    extern public function removeChangeListener(watchId: Int64): Void;
}

typedef MessagesChangeCallback = {
    var messagesadded: TizenCallback;
    var messagesupdated: TizenCallback;
    var messagesremoved: TizenCallback;
}

typedef MessageConversationsChangeCallback = {
    var conversationsadded: TizenCallback;
    var conversationsupdated: TizenCallback;
    var conversationsremoved: TizenCallback;
}

typedef MessageFoldersChangeCallback = {
    var foldersadded: TizenCallback;
    var foldersupdated: TizenCallback;
    var foldersremoved: TizenCallback;
}

typedef MessageConversation = {
    var id: MessageConvId;
    var type: EitherType<String, MessageServiceTag>;
    var timestamp: Date;
    var messageCount: Int64;
    var unreadMessages: Int64;
    var preview: String;
    var subject: String;
    var isRead: Bool;
    var from: String;
    var to: Array<String>;
    var cc: Array<String>;
    var bcc: Array<String>;
    var lastMessageID: MessageId;
}

typedef MessageFolder = {
    var id: MessageFolderId;
    var parentId: MessageFolderId;
    var serviceId: String;
    var contentType: MessageServiceTag;
    var name: String;
    var path: String;
    var type: String;
    var synchronizable: Bool;
}

@:enum abstract SystemInfoPropertyId(String) {
    var BATTERY;
    var CPU;
    var STORAGE;
    var DISPLAY;
    var DEVICE_ORIENTATION;
    var BUILD;
    var LOCALE;
    var NETWORK;
    var WIFI_NETWORK;
    var ETHERNET_NETWORK;
    var CELLULAR_NETWORK;
    var NET_PROXY_NETWORKING;
    var SIM;
    var PERIPHERAL;
    var MEMORY;
    var CAMERA_FLASH;
    var ADS;
}

@:enum abstract SystemInfoNetworkType(String) {
    var NONE;
    var CELL_2G = "2G";
    var CELL_2_POINT_5_G = "2.5G";
    var CELL_3G = "3G";
    var CELL_4G = "4G";
    var WIFI;
    var ETHERNET;
    var NET_PROXY;
    var UNKNOWN;
}

@:enum abstract SystemInfoDeviceOrientationStatus(String) {
    var PORTRAIT_PRIMARY;
    var PORTRAIT_SECONDARY;
    var LANDSCAPE_PRIMARY;
    var LANDSCAPE_SECONDARY;
}

@:enum abstract SystemInfoSimState(String) {
    var ABSENT;
    var INITIALIZING;
    var READY;
    var PIN_REQUIRED;
    var PUK_REQUIRED;
    var NETWORK_LOCKED;
    var SIM_LOCKED;
    var UNKNOWN;
}

@:enum abstract SystemInfoProfile(String) {
    var MOBILE;
    var WEARABLE;
    var TV;
}

@:enum abstract SystemInfoLowMemoryStatus(String) {
    var NORMAL;
    var WARNING;
}

@:enum abstract SystemInfoVideoSourceType(String) {
    var TV;
    var AV;
    var SVIDEO;
    var COMP;
    var PC;
    var HDMI;
    var SCART;
    var DVI;
    var MEDIA;
}

typedef SystemInfoOptions = {
    var timeout: Int64;
    var highThreshold: Float;
    var lowThreshold: Float;
}

class SystemInfo {
    public function new() {}
    extern public function getTotalMemory(): Int64;
    extern public function getAvailableMemory(): Int64;
    extern public function getCapability(key: String): Dynamic;
    extern public function getCount(property: EitherType<String, SystemInfoPropertyId>): Int64;
    extern public function getPropertyValue(property: EitherType<String, SystemInfoPropertyId>, successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function getPropertyValueArray(property: EitherType<String, SystemInfoPropertyId>, successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function addPropertyValueChangeListener(property: EitherType<String, SystemInfoPropertyId>, successCallback: TizenCallback, ?options: SystemInfoOptions, ?errorCallback: TizenCallback): Int64;
    extern public function addPropertyValueArrayChangeListener(property: EitherType<String, SystemInfoPropertyId>, successCallback: TizenCallback, ?options: SystemInfoOptions, ?errorCallback: TizenCallback): Int64;
    extern public function removePropertyValueChangeListener(listenerId: Int64): Void;
}

class SystemInfoProperty {
    public function new() {}
}

class SystemInfoBattery extends SystemInfoProperty {
    extern public function new();
    extern public var level(default, null): Float;
    extern public var isCharging(default, null): Bool;
    extern public var timeToDischarge(default, null): Int64;
    extern public var timeToFullCharge(default, null): Int64;
}

class SystemInfoCpu extends SystemInfoProperty {
    extern public function new();
    extern public var load(default, null): Float;
}

class SystemInfoStorage extends SystemInfoProperty {
    extern public function new();
    extern public var units(default, null): Array<SystemInfoStorageUnit>;
}

class SystemInfoStorageUnit extends SystemInfoProperty {
    extern public function new();
    extern public var type(default, null): String;
    extern public var capacity(default, null): Int64;
    extern public var availableCapacity(default, null): Int64;
    extern public var isRemovable(default, null): Bool;
}

class SystemInfoDisplay extends SystemInfoProperty {
    extern public function new();
    extern public var resolutionWidth(default, null): Int64;
    extern public var resolutionHeight(default, null): Int64;
    extern public var dotsPerInchWidth(default, null): Int64;
    extern public var dotsPerInchHeight(default, null): Int64;
    extern public var physicalWidth(default, null): Float;
    extern public var physicalHeight(default, null): Float;
    extern public var brightness(default, null): Float;
}

class SystemInfoDeviceOrientation extends SystemInfoProperty {
    extern public function new();
    extern public var status(default, null): EitherType<String, SystemInfoDeviceOrientationStatus>;
    extern public var isAutoRotation(default, null): Bool;
}

class SystemInfoBuild extends SystemInfoProperty {
    extern public function new();
    extern public var model(default, null): String;
    extern public var manufacturer(default, null): String;
    extern public var buildVersion(default, null): String;
}

class SystemInfoLocale extends SystemInfoProperty {
    extern public function new();
    extern public var language(default, null): String;
    extern public var country(default, null): String;
}

class SystemInfoNetwork extends SystemInfoProperty {
    extern public function new();
    extern public var networkType(default, null): EitherType<String, SystemInfoNetworkType>;
}

class SystemInfoWifiNetwork extends SystemInfoProperty {
    extern public function new();
    extern public var status(default, null): String;
    extern public var ssid(default, null): String;
    extern public var ipAddress(default, null): String;
    extern public var ipv6Address(default, null): String;
    extern public var macAddress(default, null): String;
    extern public var signalStrength(default, null): Float;
}

class SystemInfoEthernetNetwork extends SystemInfoProperty {
    extern public function new();
    extern public var cable(default, null): String;
    extern public var status(default, null): String;
    extern public var ipAddress(default, null): String;
    extern public var ipv6Address(default, null): String;
    extern public var macAddress(default, null): String;
}

class SystemInfoCellularNetwork extends SystemInfoProperty {
    extern public function new();
    extern public var status(default, null): String;
    extern public var apn(default, null): String;
    extern public var ipAddress(default, null): String;
    extern public var ipv6Address(default, null): String;
    extern public var mcc(default, null): Int;
    extern public var mnc(default, null): Int;
    extern public var cellId(default, null): Int;
    extern public var lac(default, null): Int;
    extern public var isRoaming(default, null): Bool;
    extern public var isFlightMode(default, null): Bool;
}

class SystemInfoNetProxyNetwork extends SystemInfoProperty {
    extern public function new();
    extern public var status(default, null): String;
}

class SystemInfoSIM extends SystemInfoProperty {
    extern public function new();
    extern public var state(default, null): EitherType<String, SystemInfoSimState>;
    extern public var operatorName(default, null): String;
    extern public var msisdn(default, null): String;
    extern public var iccid(default, null): String;
    extern public var mcc(default, null): Int;
    extern public var mnc(default, null): Int;
    extern public var msin(default, null): String;
    extern public var spn(default, null): String;
}

class SystemInfoPeripheral extends SystemInfoProperty {
    extern public function new();
    extern public var isVideoOutputOn(default, null): Bool;
}

class SystemInfoMemory extends SystemInfoProperty {
    extern public function new();
    extern public var status(default, null): SystemInfoLowMemoryStatus;
}

typedef SystemInfoVideoSourceInfo = {
    var type: EitherType<String, SystemInfoVideoSourceType>;
    var number: Int64;
    var signal: Bool;
}

class SystemInfoVideoSource extends SystemInfoProperty {
    extern public function new();
    extern public var connected(default, null): Array<SystemInfoVideoSourceInfo>;
    extern public var disconnected(default, null): Array<SystemInfoVideoSourceInfo>;
}

class SystemInfoCameraFlash extends SystemInfoProperty {
    extern public function new();
    extern public var brightness(default, null): Float;
    extern public var camera(default, null): String;
    extern public var levels(default, null): Int64;
    extern public function setBrightness(brightness: Float): Void;
}

class SystemInfoADS extends SystemInfoProperty {
    extern public function new();
    extern public var id(default, null): String;
}

@:enum abstract MagneticSensorAccuracy(String) {
    var ACCURACY_UNDEFINED;
    var ACCURACY_BAD;
    var ACCURACY_NORMAL;
    var ACCURACY_GOOD;
    var ACCURACY_VERYGOOD;
}

@:enum abstract ProximityState(String) {
    var FAR;
    var NEAR;
}

@:enum abstract SensorType(String) {
    var ACCELERATION;
    var GRAVITY;
    var GYROSCOPE;
    var GYROSCOPE_ROTATION_VECTOR;
    var GYROSCOPE_UNCALIBRATED;
    var HRM_RAW;
    var LIGHT;
    var LINEAR_ACCELERATION;
    var MAGNETIC;
    var MAGNETIC_UNCALIBRATED;
    var PRESSURE;
    var PROXIMITY;
    var ULTRAVIOLET;
}

class SensorService {
    public function new() {}
    extern public function getDefaultSensor(type: EitherType<String, SensorType>): Sensor;
    extern public function getAvailableSensors(): Array<EitherType<String, SensorType>>;
}

class Sensor {
    public function new() {}
    extern public var sensorType(default, null): SensorType;
    extern public function start(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function stop(): Void;
    extern public function setChangeListener(successCallback: TizenCallback, ?interval: Int64, ?batchLatency: Int64): Void;
    extern public function unsetChangeListener(): Void;
    extern public function getSensorHardwareInfo(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

class AccelerationSensor extends Sensor {
    extern public function new();
    extern public function getAccelerationSensorData(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

class GravitySensor extends Sensor {
    extern public function new();
    extern public function getGravitySensorData(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

class GyroscopeSensor extends Sensor {
    extern public function new();
    extern public function getGyroscopeSensorData(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

class GyroscopeRotationVectorSensor extends Sensor {
    extern public function new();
    extern public function getGyroscopeRotationVectorSensorData(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

class GyroscopeUncalibratedSensor extends Sensor {
    extern public function new();
    extern public function getGyroscopeUncalibratedSensorData(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

class HRMRawSensor extends Sensor {
    extern public function new();
    extern public function getHRMRawSensorData(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

class LightSensor extends Sensor {
    extern public function new();
    extern public function getLightSensorData(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

class LinearAccelerationSensor extends Sensor {
    extern public function new();
    extern public function getLinearAccelerationSensorData(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

class MagneticSensor extends Sensor {
    extern public function new();
    extern public function getMagneticSensorData(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

class MagneticUncalibratedSensor extends Sensor {
    extern public function new();
    extern public function getMagneticUncalibratedSensorData(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

class PressureSensor extends Sensor {
    extern public function new();
    extern public function getPressureSensorData(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

class ProximitySensor extends Sensor {
    extern public function new();
    extern public function getProximitySensorData(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

class UltravioletSensor extends Sensor {
    extern public function new();
    extern public function getUltravioletSensorData(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

class SensorData {
    public function new() {}
}

class SensorAccelerationData extends SensorData {
    extern public function new();
    extern public var x(default, null): Float;
    extern public var y(default, null): Float;
    extern public var z(default, null): Float;
}

class SensorGravityData extends SensorData {
    extern public function new();
    extern public var x(default, null): Float;
    extern public var y(default, null): Float;
    extern public var z(default, null): Float;
}

class SensorGyroscopeData extends SensorData {
    extern public function new();
    extern public var x(default, null): Float;
    extern public var y(default, null): Float;
    extern public var z(default, null): Float;
}

class SensorGyroscopeRotationVectorData extends SensorData {
    extern public function new();
    extern public var x(default, null): Float;
    extern public var y(default, null): Float;
    extern public var z(default, null): Float;
    extern public var w(default, null): Float;
}

class SensorGyroscopeUncalibratedData extends SensorData {
    extern public function new();
    extern public var x(default, null): Float;
    extern public var y(default, null): Float;
    extern public var z(default, null): Float;
    extern public var xAxisDrift(default, null): Float;
    extern public var yAxisDrift(default, null): Float;
    extern public var zAxisDrift(default, null): Float;
}

class SensorHRMRawData extends SensorData {
    extern public function new();
    extern public var lightType(default, null): String;
    extern public var lightIntensity(default, null): Int64;
}

class SensorLightData extends SensorData {
    extern public function new();
    extern public var lightLevel(default, null): Float;
}

class SensorLinearAccelerationData extends SensorData {
    extern public function new();
    extern public var x(default, null): Float;
    extern public var y(default, null): Float;
    extern public var z(default, null): Float;
}

class SensorMagneticData extends SensorData {
    extern public function new();
    extern public var x(default, null): Float;
    extern public var y(default, null): Float;
    extern public var z(default, null): Float;
    extern public var accuracy(default, null): EitherType<String, MagneticSensorAccuracy>;
}

class SensorMagneticUncalibratedData extends SensorData {
    extern public function new();
    extern public var x(default, null): Float;
    extern public var y(default, null): Float;
    extern public var z(default, null): Float;
    extern public var xAxisBias(default, null): Float;
    extern public var yAxisBias(default, null): Float;
    extern public var zAxisBias(default, null): Float;
}

class SensorPressureData extends SensorData {
    extern public function new();
    extern public var pressure(default, null): Float;
}

class SensorProximityData extends SensorData {
    extern public function new();
    extern public var proximityState(default, null): EitherType<String, ProximityState>;
}

class SensorUltravioletData extends SensorData {
    extern public function new();
    extern public var ultravioletLevel(default, null): Int64;
}

typedef SensorHardwareInfo = {
    var name: String;
    var type: EitherType<String, SensorType>;
    var vendor: String;
    var minValue: Float;
    var maxValue: Float;
    var resolution: Float;
    var minInterval: Int64;
    var maxBatchCount: Int64;
}

typedef ResourceType = String;
typedef ResourceInterface = String;

@:enum abstract QosLevel(String) {
    var HIGH;
    var LOW;
}

@:enum abstract ResponseResult(String) {
    var SUCCESS;
    var ERROR;
    var RESOURCE_CREATED;
    var RESOURCE_DELETED;
    var RESOURCE_CHANGED;
    var SLOW;
    var FORBIDDEN;
}

@:enum abstract PresenceResponseResultType(String) {
    var OK;
    var STOPPED;
    var TIMEOUT;
}

@:enum abstract PresenceTriggerType(String) {
    var CREATED;
    var UPDATED;
    var DESTROYED;
}

@:enum abstract ConnectivityType(String) {
    var IP;
    var PREFER_UDP;
    var PREFER_TCP;
    var IPV4_ONLY;
    var IPV6_ONLY;
    var ALL;
}

@:enum abstract ObservePolicy(String) {
    var IGNORE_OUT_OF_ORDER;
    var ACCEPT_OUT_OF_ORDER;
}

@:enum abstract ObserveType(String) {
    var NO_TYPE;
    var REGISTER;
    var DEREGISTER;
}

typedef ResourcePolicy = {
    var isObservable: Bool;
    var isDiscoverable: Bool;
    var isActive: Bool;
    var isSlow: Bool;
    var isSecure: Bool;
    var isExplicitDiscoverable: Bool;
}

typedef Query = {
    var ?resourceType: ResourceType;
    var ?resourceInterface: ResourceInterface;
    var ?filter: Dynamic;
}

class Iotcon {
    public function new() {}
    extern public function initialize(filePath: String): Void;
    extern public function getClient(): Client;
    extern public function getServer(): Server;
    extern public function getTimeout(): Int64;
    extern public function setTimeout(timeout: Int64): Void;
    extern public function addGeneratedPinListener(successCallback: TizenCallback): Int64;
    extern public function removeGeneratedPinListener(watchId: Int64): Void;
}

class Client {
    public function new() {}
    extern public function findResource(hostAddress: String, query: Query, connectivityType: EitherType<String, ConnectivityType>, successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function addPresenceEventListener(hostAddress: String, resourceType: ResourceType, connectivityType: EitherType<String, ConnectivityType>, successCallback: TizenCallback): Int64;
    extern public function removePresenceEventListener(watchId: Int64): Void;
    extern public function findDeviceInfo(hostAddress: String, query: Query, connectivityType: EitherType<String, ConnectivityType>, successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function findPlatformInfo(hostAddress: String, query: Query, connectivityType: EitherType<String, ConnectivityType>, successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

class Server {
    public function new() {}
    extern public function getResources(): Array<Resource>;
    extern public function createResource(uriPath: String, resourceTypes: Array<ResourceType>, resourceInterfaces: Array<ResourceInterface>, listener: RequestCallback, ?policy: ResourcePolicy): Resource;
    extern public function removeResource(resource: Resource): Void;
    extern public function startPresence(timeToLive: Int64): Void;
    extern public function stopPresence(): Void;
}

class RemoteResource {
    public function new() {}
    extern public var uriPath(default, null): String;
    extern public var connectivityType(default, null): ConnectivityType;
    extern public var hostAddress(default, null): String;
    extern public var resourceTypes(default, null): Array<ResourceType>;
    extern public var resourceInterfaces(default, null): Array<ResourceInterface>;
    extern public var isObservable(default, null): Bool;
    extern public var isDiscoverable(default, null): Bool;
    extern public var isActive(default, null): Bool;
    extern public var isSlow(default, null): Bool;
    extern public var isSecure(default, null): Bool;
    extern public var isExplicitDiscoverable(default, null): Bool;
    extern public var deviceId(default, null): String;
    extern public var deviceName(default, null): String;
    extern public var options(default, null): Array<IotconOption>;
    extern public var cachedRepresentation(default, null): Representation;
    extern public var timeInterval(default, null): Int64;
    extern public function methodGet(responseCallback: TizenCallback, ?query: Query, ?errorCallback: TizenCallback): Void;
    extern public function methodPut(representation: Representation, responseCallback: TizenCallback, ?query: Query, ?errorCallback: TizenCallback): Void;
    extern public function methodPost(representation: Representation, responseCallback: TizenCallback, ?query: Query, ?errorCallback: TizenCallback): Void;
    extern public function methodDelete(responseCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function startObserving(observePolicy: EitherType<String, ObservePolicy>, successCallback: TizenCallback, ?query: Query): Void;
    extern public function stopObserving(): Void;
    extern public function startCachine(?updatedCallback: TizenCallback): Void;
    extern public function stopCaching(): Void;
    extern public function setResourceStateChangeListener(successCallback: TizenCallback): Void;
    extern public function unsetResourceStateChangeListener(): Void;
}

class Resource {
    public function new() {}
    extern public var uriPath(default, null): String;
    extern public var resourceTypes(default, null): Array<ResourceType>;
    extern public var resourceInterfaces(default, null): Array<ResourceInterface>;
    extern public var isObservable(default, null): Bool;
    extern public var isDiscoverable(default, null): Bool;
    extern public var isActive(default, null): Bool;
    extern public var isSlow(default, null): Bool;
    extern public var isSecure(default, null): Bool;
    extern public var isExplicitDiscoverable(default, null): Bool;
    extern public var resources(default, null): Array<Resource>;
    extern public var observerIds(default, null): Array<Int64>;
    extern public var attributes(default, null): Dynamic;
    extern public function notify(qosLevel: EitherType<String, QosLevel>, ?observerIds: Array<Int64>): Void;
    extern public function addResourceTypes(types: Array<ResourceType>): Void;
    extern public function addResourceInterface(res_interface: ResourceInterface): Void;
    extern public function addChildResource(resource: Resource): Void;
    extern public function removeChildResource(resource: Resource): Void;
    extern public function setRequestListener(listener: RequestCallback): Void;
    extern public function unsetRequestListener(): Void;
}

@:native("tizen.Representation")
extern class Representation {
    extern public function new(uriPath: String);
    extern public var uriPath(default, null): String;
    extern public var resourceTypes(default, null): Array<ResourceType>;
    extern public var resourceInterfaces(default, null): Array<ResourceInterface>;
    extern public var attributes(default, null): Dynamic;
    extern public var children(default, null): Array<Representation>;
}

typedef PresenceResponse = {
    var hostAddress: String;
    var connectivityType: EitherType<String, ConnectivityType>;
    var resourceType: ResourceType;
    var resultType: EitherType<String, PresenceResponseResultType>;
    var triggerType: EitherType<String, PresenceTriggerType>;
}

@:native("tizen.IotconOption")
extern class IotconOption {
    extern public function new(id: Int64, data: String);
    extern public var id(default, null): Int64;
    extern public var data(default, null): String;
}

typedef Request = {
    var hostAddress: String;
    var connectivityType: EitherType<String, ConnectivityType>;
    var representation: Representation;
    var options: Array<IotconOption>;
    var query: Query;
}

@:native("tizen.Response")
extern class Response {
    extern public function new(request: Request);
    extern public var request(default, null): Request;
    extern public var result(default, null): EitherType<String, ResponseResult>;
    extern public var representation(default, null): Representation;
    extern public var options(default, null): Array<IotconOption>;
    extern public function send(): Void;
}

typedef RemoteResponse = {
    var result: EitherType<String, ResponseResult>;
    var representation: Representation;
    var options: Array<IotconOption>;
}

typedef DeviceInfo = {
    var ?deviceName: String;
    var ?specVersion: String;
    var ?oicDeviceId: String;
    var ?dataModelVersion: String;
}

typedef PlatformInfo = {
    var ?platformId: String;
    var ?manufacturerName: String;
    var ?manufacturerUrl: String;
    var ?modelNumber: String;
    var ?manufactureDate: String;
    var ?platformVersion: String;
    var ?operatingSystemVersion: String;
    var ?hardwareVersion: String;
    var ?firmwareVersion: String;
    var ?supportUrl: String;
    var ?systemTime: String;
}

typedef RequestCallback = {
    var onget: TizenCallback;
    var onput: TizenCallback;
    var onpost: TizenCallback;
    var ondelete: TizenCallback;
    var onobserving: TizenCallback;
}

typedef AID = String;

@:enum abstract NDEFRecordTextEncoding(String) {
    var UTF8;
    var UTF16;
}

@:enum abstract NFCTagType(String) {
    var GENERIC_TARGET;
    var ISO14443_A;
    var ISO14443_4A;
    var ISO14443_3A;
    var MIFARE_MINI;
    var MIFARE_1K;
    var MIFARE_4K;
    var MIFARE_ULTRA;
    var MIFARE_DESFIRE;
    var ISO14443_B;
    var ISO14443_4B;
    var ISO14443_BPRIME;
    var FELICA;
    var JEWEL;
    var ISO15693;
    var UNKNOWN_TARGET;
}

@:enum abstract CardEmulationMode(String) {
    var ALWAYS_ON;
    var OFF;
}

@:enum abstract SecureElementType(String) {
    var ESE;
    var UICC;
    var HCE;
}

@:enum abstract CardEmulationCategoryType(String) {
    var PAYMENT;
    var OTHER;
}

@:enum abstract HCEEventType(String) {
    var DEACTIVATED;
    var ACTIVATED;
    var APDU_RECEIVED;
}

class NFCManager {
    public function new() {}
    extern public var NFC_RECORD_TNF_EMPTY(default, null): Int;
    extern public var NFC_RECORD_TNF_WELL_KNOWN(default, null): Int;
    extern public var NFC_RECORD_TNF_MIME_MEDIA(default, null): Int;
    extern public var NFC_RECORD_TNF_URI(default, null): Int;
    extern public var NFC_RECORD_TNF_EXTERNAL_RTD(default, null): Int;
    extern public var NFC_RECORD_TNF_UNKNOWN(default, null): Int;
    extern public var NFC_RECORD_TNF_UNCHANGED(default, null): Int;
    extern public function getDefaultAdapter(): NFCAdapter;
    extern public function setExclusiveMode(mode: Bool): Void;
}

class NFCAdapter {
    public function new() {}
    extern public var powered(default, null): Bool;
    extern public var cardEmulationMode(default, null): EitherType<String, CardEmulationMode>;
    extern public var activeSecureElement(default, null): EitherType<String, SecureElementType>;
    extern public function setTagListener(detectCallback: NFCTagDetectCallback, ?tagFilter: Array<EitherType<String, NFCTagType>>): Void;
    extern public function setPeerListener(detectCallback: NFCPeerDetectCallback, ?tagFilter: Array<EitherType<String, NFCTagType>>): Void;
    extern public function unsetTagListener(): Void;
    extern public function unsetPeerListener(): Void;
    extern public function addCardEmulationModeChangeListener(changeCallback: TizenCallback): Int64;
    extern public function removeCardEmulationModeChangeListener(watchId: Int64): Void;
    extern public function addTransactionEventListener(type: EitherType<String, SecureElementType>, eventCallback: TizenCallback): Int64;
    extern public function removeTransactionEventListener(watchId: Int64): Void;
    extern public function addActiveSecureElementChangeListener(changeCallback: TizenCallback): Int64;
    extern public function removeActiveSecureElementChangeListener(watchId: Int64): Void;
    extern public function getCachedMessage(): NDEFMessage;
    extern public function setExclusiveModeForTransaction(mode: Bool): Void;
    extern public function addHCEEventListener(eventCallback: TizenCallback): Int64;
    extern public function removeHCEEventListener(watchId: Int64): Void;
    extern public function sendHostAPDUResponse(apdu: UInt8Array, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function isActivatedHandlerForAID(type: EitherType<String, SecureElementType>, aid: AID): Bool;
    extern public function isActivatedHandlerForCategory(type: EitherType<String, SecureElementType>, category: EitherType<String, CardEmulationCategoryType>): Bool;
    extern public function registerAID(type: EitherType<String, SecureElementType>, aid: AID, category: EitherType<String, CardEmulationCategoryType>): Void;
    extern public function unregisterAID(type: EitherType<String, SecureElementType>, aid: AID, category: EitherType<String, CardEmulationCategoryType>): Void;
    extern public function getAIDsForCategory(type: EitherType<String, SecureElementType>, aid: AID, category: EitherType<String, CardEmulationCategoryType>, successCallback: TizenCallback): Void;
    extern public function setPreferredApp(): Void;
    extern public function unsetPreferredApp(): Void;
}

class NFCTag {
    public function new() {}
    extern public var type(default, null): NFCTagType;
    extern public var isSupportedNDEF(default, null): Bool;
    extern public var ndefSize(default, null): Int64;
    extern public var properties(default, null): Dynamic;
    extern public var isConnected(default, null): Bool;
    extern public function readNDEF(readCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function writeNDEF(ndefMessage: NDEFMessage, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function transceive(data: UInt8Array, dataCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

class NFCPeer {
    public function new() {}
    extern public var isConnected(default, null): Bool;
    extern public function setReceiveNDEFListener(successCallback: TizenCallback): Void;
    extern public function unsetReceiveNDEFListener(): Void;
    extern public function sendNDEF(ndefMessage: NDEFMessage, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

@:native("tizen.NDEFMessage")
extern class NDEFMessage {
    extern public function new(?records_or_rawdata: Array<EitherType<Int, NDEFRecord>>);
    extern public var recordCount(default, null): Int64;
    extern public var records(default, null): Array<NDEFRecord>;
    extern public function toByte(): UInt8Array;
}

@:native("tizen.NDEFRecord")
extern class NDEFRecord {
    extern public function new(rawdata_or_tnf: EitherType<Int, UInt8Array>, type: UInt8Array, payload: UInt8Array, ?id: UInt8Array);
    extern public var tnf(default, null): Int;
    extern public var type(default, null): UInt8Array;
    extern public var id(default, null): UInt8Array;
    extern public var payload(default, null): UInt8Array;
}

@:native("tizen.NDEFRecordText")
extern class NDEFRecordText extends NDEFRecord {
    extern public function new(text: String, languageCode: String, ?encoding: String);
    extern public var text(default, null): String;
    extern public var languageCode(default, null): String;
    extern public var encoding(default, null): EitherType<String, NDEFRecordTextEncoding>;
}

@:native("tizen.NDEFRecordURI")
extern class NDEFRecordURI extends NDEFRecord {
    extern public function new(uri: String);
    extern public var uri(default, null): String;
}

@:native("tizen.NDEFRecordMedia")
extern class NDEFRecordMedia extends NDEFRecord {
    extern public function new(mimeType: String, data: UInt8Array);
    extern public var mimeType(default, null): String;
}

typedef HCEEventData = {
    var eventType: HCEEventType;
    var apdu: UInt8Array;
    var length: Int64;
}

typedef AIDData = {
    var type: EitherType<String, SecureElementType>;
    var aid: AID;
    var readOnly: Bool;
}

typedef NFCTagDetectCallback = {
    var onattach: TizenCallback;
    var ondetach: TizenCallback;
}

typedef NFCPeerDetectCallback = {
    var onattach: TizenCallback;
    var ondetach: TizenCallback;
}

@:enum abstract HumanActivityType(String) {
    var PEDOMETER;
    var HRM;
    var GPS;
    var SLEEP_MONITOR;
    var SLEEP_DETECTOR;
    var STRESS_MONITOR;
}

@:enum abstract ActivityRecognitionType(String) {
    var STATIONARY;
    var WALKING;
    var RUNNING;
    var IN_VEHICLE;
}

@:enum abstract ActivityAccuracy(String) {
    var LOW;
    var MEDIUM;
    var HIGH;
}

@:enum abstract HumanActivityRecorderType(String) {
    var PEDOMETER;
    var HRM;
    var SLEEP_MONITOR;
    var PRESSURE;
}

@:enum abstract PedometerStepStatus(String) {
    var NOT_MOVING;
    var WALKING;
    var RUNNING;
    var UNKNOWN;
}

@:enum abstract SleepStatus(String) {
    var ASLEEP;
    var AWAKE;
    var UNKNOWN;
}

@:enum abstract GestureType(String) {
    var GESTURE_Float_TAP;
    var GESTURE_MOVE_TO_EAR;
    var GESTURE_NO_MOVE;
    var GESTURE_PICK_UP;
    var GESTURE_SHAKE;
    var GESTURE_SNAP;
    var GESTURE_TILT;
    var GESTURE_TURN_FACE_DOWN;
    var GESTURE_WRIST_UP;
}

@:enum abstract GestureEvent(String) {
    var GESTURE_EVENT_DETECTED;
    var GESTURE_SHAKE_DETECTED;
    var GESTURE_SHAKE_FINISHED;
    var GESTURE_SNAP_X_NEGATIVE;
    var GESTURE_SNAP_X_POSITIVE;
    var GESTURE_SNAP_Y_NEGATIVE;
    var GESTURE_SNAP_Y_POSITIVE;
    var GESTURE_SNAP_Z_NEGATIVE;
    var GESTURE_SNAP_Z_POSITIVE;
}

typedef HumanActivityRecorderOption = {
    var interval: Int64;
    var retentionPeriod: Int64;
}

typedef HumanActivityRecorderQuery = {
    var startTime: Int64;
    var endTime: Int64;
    var anchorTime: Int64;
    var interval: Int64;
}

typedef HumanActivityMonitorOption = {
    var callbackInterval: Int64;
    var sampleInterval: Int64;
}

class HumanActivityMonitorManager {
    public function new() {}
    extern public function getHumanActivityData(type: EitherType<String, HumanActivityType>, successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function start(type: EitherType<String, HumanActivityType>, changedCallback: TizenCallback, ?errorCallback: TizenCallback, ?option: HumanActivityMonitorOption): Void;
    extern public function stop(type: EitherType<String, HumanActivityType>): Void;
    extern public function setAccumulativePedometerListener(changeCallback: TizenCallback): Void;
    extern public function unsetAccumulativePedometerListener(): Void;
    extern public function addActivityRecognitionListener(type: EitherType<String, ActivityRecognitionType>, listener: TizenCallback, ?errorCallback: TizenCallback): Int64;
    extern public function removeActivityRecognitionListener(listenerId: Int64, ?errorCallback: TizenCallback): Void;
    extern public function startRecorder(type: EitherType<String, HumanActivityRecorderType>, ?option: HumanActivityMonitorOption): Void;
    extern public function stopRecorder(type: EitherType<String, HumanActivityRecorderType>): Void;
    extern public function readRecorderData(type: EitherType<String, HumanActivityRecorderType>, query: HumanActivityRecorderQuery, successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function isGestureSupported(type: EitherType<String, GestureType>): Bool;
    extern public function addGestureRecognitionListener(type: EitherType<String, GestureType>, listener: TizenCallback, ?errorCallback: TizenCallback, ?alwaysOn: Bool): Int64;
    extern public function removeGestureRecognitionListener(watchId: Int64): Void;
    extern public function addStressMonitorChangeListener(ranges: Array<StressMonitorDataRange>, listener: TizenCallback): Int64;
    extern public function removeStressMonitorChangeListener(watchId: Int64): Void;
}

typedef StepDifference = {
    var stepCountDifference: Int64;
    var timestamp: Int64;
}

class HumanActivityData {
    public function new() {}
}

class HumanActivityPedometerData extends HumanActivityData {
    extern public function new();
    extern public var stepStatus(default, null): EitherType<String, PedometerStepStatus>;
    extern public var speed(default, null): Float;
    extern public var walkingFrequency(default, null): Float;
    extern public var cumulativeDistance(default, null): Float;
    extern public var cumulativeCalorie(default, null): Float;
    extern public var cumulativeTotalStepCount(default, null): Float;
    extern public var cumulativeWalkStepCount(default, null): Float;
    extern public var cumulativeRunStepCount(default, null): Float;
    extern public var accumulativeDistance(default, null): Float;
    extern public var accumulativeCalorie(default, null): Float;
    extern public var accumulativeTotalStepCount(default, null): Float;
    extern public var accumulativeWalkStepCount(default, null): Float;
    extern public var accumulativeRunStepCount(default, null): Float;
    extern public var stepCountDifferences(default, null): Array<StepDifference>;
}

class HumanActivityAccumulativePedometerData extends HumanActivityData {
    extern public function new();
    extern public var stepStatus(default, null): EitherType<String, PedometerStepStatus>;
    extern public var speed(default, null): Float;
    extern public var walkingFrequency(default, null): Float;
    extern public var accumulativeDistance(default, null): Float;
    extern public var accumulativeCalorie(default, null): Float;
    extern public var accumulativeTotalStepCount(default, null): Float;
    extern public var accumulativeWalkStepCount(default, null): Float;
    extern public var accumulativeRunStepCount(default, null): Float;
    extern public var stepCountDifferences(default, null): Array<StepDifference>;
}

class HumanActivityHRMData extends HumanActivityData {
    extern public function new();
    extern public var heartRate(default, null): Int64;
    extern public var rRInterval(default, null): Int64;
}

class HumanActivityRecognitionData extends HumanActivityData {
    extern public function new();
    extern public var type(default, null): EitherType<String, ActivityRecognitionType>;
    extern public var timestamp(default, null): Int64;
    extern public var accuracy(default, null): EitherType<String, ActivityAccuracy>;
}

typedef HumanActivityGPSInfo = {
    var latitude: Float;
    var longitude: Float;
    var altitude: Float;
    var speed: Float;
    var errorRange: Int64;
    var timestamp: Int64;
}

class HumanActivityGPSInfoArray extends HumanActivityData {
    extern public function new();
    extern public var gpsInfo(default, null): Array<HumanActivityGPSInfo>;
}

class HumanActivitySleepMonitorData extends HumanActivityData {
    extern public function new();
    extern public var status(default, null): EitherType<String, SleepStatus>;
    extern public var timestamp(default, null): Int64;
}

class HumanActivitySleepDetectorData extends HumanActivityData {
    extern public function new();
    extern public var status(default, null): EitherType<String, SleepStatus>;
}

class HumanActivityRecorderData extends HumanActivityData {
    extern public function new();
    extern public var startTime(default, null): Int64;
    extern public var endTime(default, null): Int64;
}

class HumanActivityRecorderPedometerData extends HumanActivityData {
    extern public function new();
    extern public var distance(default, null): Float;
    extern public var calorie(default, null): Float;
    extern public var totalStepCount(default, null): Float;
    extern public var walkStepCount(default, null): Float;
    extern public var runStepCount(default, null): Float;
}
 
class HumanActivityRecorderHRMData extends HumanActivityData {
    extern public function new();
    extern public var heartRate(default, null): Int64;
}

class HumanActivityRecorderSleepMonitorData extends HumanActivityData {
    extern public function new();
    extern public var status(default, null): EitherType<String, SleepStatus>;
}

class HumanActivityRecorderPressureData extends HumanActivityData {
    extern public function new();
    extern public var max(default, null): Float;
    extern public var min(default, null): Float;
    extern public var average(default, null): Float;
}

@:native("tizen.StressMonitorDataRange")
extern class StressMonitorDataRange {
    extern public function new(?label: String, ?min: Int64, ?max: Int64);
    extern public var label(default, null): String;
    extern public var min(default, null): Int64;
    extern public var max(default, null): Int64;
}

typedef GestureData = {
    var type: EitherType<String, GestureType>;
    var event: EitherType<String, GestureEvent>;
    var timestamp: Int64;
    var x: Float;
    var y: Float;
}

typedef CalendarId = String;
typedef CalendarTaskId = String;
typedef CalendarItemId = EitherType<CalendarEventId, CalendarTaskId>;

@:enum abstract CalendarType(String) {
    var EVENT;
    var TASK;
}

@:enum abstract CalendarTextFormat(String) {
    var ICALENDAR_20;
    var VCALENDAR_10;
}

@:enum abstract AlarmMethod(String) {
    var SOUND;
    var DISPLAY;
}

@:enum abstract RecurrenceRuleFrequency(String) {
    var DAILY;
    var WEEKLY;
    var MONTHLY;
    var YEARLY;
}

@:enum abstract ByDayValue(String) {
    var MO;
    var TU;
    var WE;
    var TH;
    var FR;
    var SA;
    var SU;
}

@:enum abstract EventAvailability(String) {
    var BUSY;
    var FREE;
    var BUSY_UNAVAILABLE;
    var BUSY_TENTATIVE;
}

@:enum abstract AttendeeType(String) {
    var INDIVIDUAL;
    var GROUP;
    var RESOURCE;
    var ROOM;
    var UNKNOWN;
}

@:enum abstract AttendeeStatus(String) {
    var PENDING;
    var ACCEPTED;
    var DECLINED;
    var TENTATIVE;
    var DELEGATED;
    var COMPLETED;
    var IN_PROCESS;
}

@:enum abstract AttendeeRole(String) {
    var REQ_PARTICIPANT;
    var OPT_PARTICIPANT;
    var NON_PARTICIPANT;
    var CHAIR;
}

@:enum abstract CalendarItemPriority(String) {
    var HIGH;
    var MEDIUM;
    var LOW;
    var NONE;
}

@:enum abstract CalendarItemVisibility(String) {
    var PUBLIC;
    var PRIVATE;
    var CONFIDENTIAL;
}

@:enum abstract CalendarItemStatus(String) {
    var NONE;
    var TENTATIVE;
    var CONFIRMED;
    var CANCELLED;
    var NEEDS_ACTION;
    var IN_PROCESS;
    var COMPLETED;
}

class CalendarItemInit {
    public function new() {}
    extern public var description(default, null): String;
    extern public var summary(default, null): String;
    extern public var isAllDay(default, null): Bool;
    extern public var startDate(default, null): TZDate;
    extern public var duration(default, null): TimeDuration;
    extern public var location(default, null): String;
    extern public var geolocation(default, null): SimpleCoordinates;
    extern public var organizer(default, null): String;
    extern public var visibility(default, null): EitherType<String, CalendarItemVisibility>;
    extern public var status(default, null): EitherType<String, CalendarItemStatus>;
    extern public var priority(default, null): EitherType<String, CalendarItemPriority>;
    extern public var alarms(default, null): Array<CalendarAlarm>;
    extern public var categories(default, null): Array<String>;
    extern public var attendees(default, null): Array<CalendarAttendee>;
}

class CalendarTaskInit extends CalendarItemInit {
    extern public function new();
    extern public var dueDate(default, null): TZDate;
    extern public var completedDate(default, null): TZDate;
    extern public var progress(default, null): Int;
}

class CalendarEventInit extends CalendarItemInit {
    extern public function new();
    extern public var endDate(default, null): TZDate;
    extern public var availability(default, null): EitherType<String, EventAvailability>;
    extern public var recurrenceRule(default, null): CalendarRecurrenceRule;
}

typedef CalendarAttendeeInit = {
    var name: String;
    var role: EitherType<String, AttendeeRole>;
    var status: EitherType<String, AttendeeStatus>;
    var RSVP: Bool;
    var type: EitherType<String, AttendeeType>;
    var ?group: String;
    var delegatorURI: String;
    var delegateURI: String;
    var contactRef: ContactRef;
}

typedef CalendarRecurrenceRuleInit = {
    var interval: Int;
    var untilDate: TZDate;
    var occurrenceCount: Int64;
    var daysOfTheWeek: Array<EitherType<String, ByDayValue>>;
    var setPositions: UInt8Array;
    var exceptions: Array<TZDate>;
}

class CalendarManager {
    public function new() {}
    extern public function getCalendars(type: EitherType<String, CalendarType>, successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function getUnifiedCalendar(type: EitherType<String, CalendarType>): Calendar;
    extern public function getDefaultCalendar(type: EitherType<String, CalendarType>): Calendar;
    extern public function addCalendar(calendar: Calendar): Void;
    extern public function removeCalendar(type: EitherType<String, CalendarType>, id: CalendarId): Void;    
    extern public function getCalendar(type: EitherType<String, CalendarType>, id: CalendarId): Calendar;    
}

@:native("tizen.Calendar")
extern class Calendar {
    extern public function new(accountId: AccountId, name: String, type: EitherType<String, CalendarType>);
    extern public var id(default, null): CalendarId;
    extern public var name(default, null): String;
    extern public var accountId(default, null): AccountId;
    extern public function get(id: CalendarItemId): CalendarItem;
    extern public function add(item: CalendarItem): Void;
    extern public function addBatch(items: Array<CalendarItem>, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function update(item: CalendarItem, ?updateAllInstances: Bool): Void;
    extern public function updateBatch(items: Array<CalendarItem>, ?successCallback: TizenCallback, ?errorCallback: TizenCallback, ?updateAllInstances: Bool): Void;
    extern public function remove(id: CalendarItemId): Void;
    extern public function removeBatch(ids: Array<CalendarItemId>, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function find(successCallback: TizenCallback, ?errorCallback: TizenCallback, ?filter: AbstractFilter, ?sortMode: SortMode): Void;
    extern public function addChangeListener(successCallback: CalendarChangeCallback): Int64;
    extern public function removeChangeListener(watchId: Int64): Void;
}

class CalendarItem {
    public function new() {}
    extern public var id(default, null): CalendarItemId;
    extern public var calendarId(default, null): CalendarId;
    extern public var lastModificationDate(default, null): TZDate;
    extern public var description(default, null): String;
    extern public var summary(default, null): String;
    extern public var isAllDay(default, null): Bool;
    extern public var startDate(default, null): TZDate;
    extern public var duration(default, null): TimeDuration;
    extern public var location(default, null): String;
    extern public var geolocation(default, null): SimpleCoordinates;
    extern public var organizer(default, null): String;
    extern public var visibility(default, null): EitherType<String, CalendarItemVisibility>;
    extern public var status(default, null): EitherType<String, CalendarItemStatus>;
    extern public var priority(default, null): EitherType<String, CalendarItemPriority>;
    extern public var alarms(default, null): Array<CalendarAlarm>;
    extern public var categories(default, null): Array<String>;
    extern public var attendees(default, null): Array<CalendarAttendee>;
    extern public function convertToString(format: EitherType<String, CalendarTextFormat>): String;
    extern public function clone(format: EitherType<String, CalendarTextFormat>): CalendarItem;
}

@:native("tizen.CalendarTask")
extern class CalendarTask extends CalendarItem {
    extern public function new(?taskInitDict_or_stringRepresentation: EitherType<CalendarTaskInit, String>, ?format: EitherType<String, CalendarTextFormat>);
    extern public var dueDate(default, null): TZDate;
    extern public var completedDate(default, null): TZDate;
    extern public var progress(default, null): Int;
}

@:native("tizen.CalendarEvent")
extern class CalendarEvent extends CalendarItem {
    extern public function new(?taskInitDict_or_stringRepresentation: EitherType<CalendarTaskInit, String>, ?format: EitherType<String, CalendarTextFormat>);
    extern public var isDetached(default, null): Bool;
    extern public var endDate(default, null): TZDate;
    extern public var availability(default, null): EitherType<String, EventAvailability>;
    extern public var recurrenceRule(default, null): CalendarRecurrenceRule;
    extern public function expandRecurrence(startDate: TZDate, endDate: TZDate, successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

@:native("tizen.CalendarAttendee")
extern class CalendarAttendee {
    extern public function new(uri: String, ?attendeeInitDict: CalendarAttendeeInit);
    extern public var uri(default, null): String;
    extern public var name(default, null): String;
    extern public var role(default, null): EitherType<String, AttendeeRole>;
    extern public var status(default, null): EitherType<String, AttendeeStatus>;
    extern public var RSVP(default, null): Bool;
    extern public var type(default, null): EitherType<String, AttendeeType>;
    extern public var group(default, null): String;
    extern public var delegatorURI(default, null): String;
    extern public var delegateURI(default, null): String;
    extern public var contactRef(default, null): ContactRef;
}

@:native("tizen.CalendarRecurrenceRule")
extern class CalendarRecurrenceRule {
    extern public function new(frequency: EitherType<String, RecurrenceRuleFrequency>, ?ruleInitDict: CalendarRecurrenceRuleInit);
    extern public var frequency(default, null): EitherType<String, RecurrenceRuleFrequency>;
    extern public var interval(default, null): Int;
    extern public var untilDate(default, null): TZDate;
    extern public var occurrenceCount(default, null): Int64;
    extern public var daysOfTheWeek(default, null): Array<EitherType<String, ByDayValue>>;
    extern public var setPositions(default, null): UInt8Array;
    extern public var exceptions(default, null): Array<TZDate>;
}

@:native("tizen.CalendarEventId")
extern class CalendarEventId {
    extern public function new(uid: String, ?rid: String);
    extern public var uid(default, null): String;
    extern public var rid(default, null): String;
}

@:native("tizen.CalendarAlarm")
extern class CalendarAlarm {
    extern public function new(absoluteDate_or_before: EitherType<TZDate, TimeDuration>, method: EitherType<String, AlarmMethod>, ?description: String);
    extern public var absoluteDate(default, null): TZDate;
    extern public var before(default, null): TimeDuration;
    extern public var method(default, null): AlarmMethod;
    extern public var description(default, null): String;
}

typedef CalendarChangeCallback = {
    var onitemsadded: TizenCallback;
    var onitemsupdated: TizenCallback;
    var onitemsremoved: TizenCallback;
}

typedef BluetoothAddress = String;
typedef BluetoothUUID = String;
typedef BluetoothLESolicitationUUID = String;
typedef Bytes = EitherType<EitherType<UInt8Array, String>, UInt8Array>;
typedef BluetoothGATTServiceVariant = EitherType<BluetoothGATTService, BluetoothGATTServerService>;
typedef BluetoothGATTCharacteristicVariant = EitherType<BluetoothGATTCharacteristic, BluetoothGATTServerCharacteristic>;
typedef BluetoothGATTDescriptorVariant = EitherType<BluetoothGATTDescriptor, BluetoothGATTServerDescriptor>;

@:enum abstract BluetoothSocketState(String) {
    var CLOSED;
    var OPEN;
}

@:enum abstract BluetoothProfileType(String) {
    var HEALTH;
}

@:enum abstract BluetoothHealthChannelType(String) {
    var RELIABLE;
    var STREAMING;
}

@:enum abstract BluetoothAdvertisePacketType(String) {
    var ADVERTISE;
    var SCAN_RESPONSE;
    var STARTED;
    var STOPPED;
}

@:enum abstract BluetoothAdvertisingState(String) {
    var STARTED;
    var STOPPED;
}

@:enum abstract BluetoothAdvertisingMode(String) {
    var BALANCED;
    var LOW_LATENCY;
    var LOW_ENERGY;
}

typedef BluetoothLEAdvertiseDataInit = {
    var ?includeName: Bool;
    var ?uuids: Array<BluetoothUUID>;
    var ?solicitationuuids: Array<BluetoothLESolicitationUUID>;
    var ?appearance: Int64;
    var ?includeTxPowerLevel: Bool;
    var ?servicesData: Array<BluetoothLEServiceData>;
    var ?manufacturerData: Array<BluetoothLEManufacturerData>;
}

typedef BluetoothGATTServerServiceInit = {
    var serviceUuid: BluetoothUUID;
    var ?isPrimary: Bool;
    var ?includedServices: Array<BluetoothGATTServerServiceInit>;
    var ?characteristics: Array<BluetoothGATTServerCharacteristicInit>;
}

@:publicFields
typedef BluetoothGATTServerCharacteristicInit = {
    var uuid: BluetoothUUID;
    var ?descriptors: Array<BluetoothGATTServerDescriptorInit>;
    var ?isBroadcast: Bool;
    var ?hasExtendedProperties: Bool;
    var ?isNotify: Bool;
    var ?isIndication: Bool;
    var ?isReadable: Bool;
    var ?isSignedWrite: Bool;
    var ?isWritable: Bool;
    var ?isWriteNoResponse: Bool;
    var ?readPermission: Bool;
    var ?writePermission: Bool;
    var ?encryptedReadPermission: Bool;
    var ?encryptedWritePermission: Bool;
    var ?encryptedSignedReadPermission: Bool;
    var ?encryptedSignedWritePermission: Bool;
    var ?readValueRequestCallback: TizenCallback;
    var ?readValueSendResponseSuccessCallback: TizenCallback;
    var ?readValueSendResponseErrorCallback: TizenCallback;
    var ?writeValueRequestCallback: TizenCallback;
    var ?writeValueSendResponseSuccessCallback: TizenCallback;
    var ?writeValueSendResponseErrorCallback: TizenCallback;
}

typedef BluetoothGATTServerDescriptorInit = {
    var uuid: BluetoothUUID;
    var ?readPermission: Bool;
    var ?writePermission: Bool;
    var ?encryptedReadPermission: Bool;
    var ?encryptedWritePermission: Bool;
    var ?encryptedSignedReadPermission: Bool;
    var ?encryptedSignedWritePermission: Bool;
    var ?readValueRequestCallback: TizenCallback;
    var ?readValueSendResponseSuccessCallback: TizenCallback;
    var ?readValueSendResponseErrorCallback: TizenCallback;
    var ?writeValueRequestCallback: TizenCallback;
    var ?writeValueSendResponseSuccessCallback: TizenCallback;
    var ?writeValueSendResponseErrorCallback: TizenCallback;
}

@:native("tizen.BluetoothLEManufacturerData")
extern class BluetoothLEManufacturerData {
    extern public function new(id: String, data: String);
    extern public var id(default, null): String;
    extern public var data(default, null): String;
}

@:native("tizen.BluetoothLEServiceData")
extern class BluetoothLEServiceData {
    extern public function new(uuid: String, data: Bytes);
    extern public var uuid(default, null): BluetoothUUID;
    extern public var data(default, null): String;
}

@:native("tizen.BluetoothLEAdvertiseData")
extern class BluetoothLEAdvertiseData {
    extern public function new(?init: BluetoothLEAdvertiseDataInit);
    extern public var includeName(default, null): Bool;
    extern public var uuids(default, null): Array<BluetoothUUID>;
    extern public var solicitationuuids(default, null): Array<BluetoothLESolicitationUUID>;
    extern public var appearance(default, null): Int64;
    extern public var includeTxPowerLevel(default, null): Bool;
    extern public var servicesData(default, null): Array<BluetoothLEServiceData>;
    extern public var manufacturerData(default, null): Array<BluetoothLEManufacturerData>;
}

class BluetoothProfileHandler {
    public function new() {}
    extern public var profileType(default, null): BluetoothProfileType;
}

class BluetoothHealthProfileHandler extends BluetoothProfileHandler {
    extern public function new();
    extern public function registerSinkApplication(dataType: UInt, name: String, successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function connectToSource(peer: BluetoothDevice, application: BluetoothHealthApplication, successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

class BluetoothHealthApplication {
    public function new() {}
    extern public var dataType(default, null): UInt;
    extern public var name(default, null): String;
    extern public var onconnect(default, null): TizenCallback;
    extern public function unregister(?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

class BluetoothHealthChannel {
    public function new() {}
    extern public var peer(default, null): BluetoothDevice;
    extern public var channelType(default, null): EitherType<String, BluetoothHealthChannelType>;
    extern public var application(default, null): BluetoothHealthApplication;
    extern public var isConnected(default, null): Bool;
    extern public function close(): Void;
    extern public function sendData(data: UInt8Array): Int64;
    extern public function setListener(listener: BluetoothHealthChannelChangeCallback): Void;
    extern public function unsetListener(): Void;
}

typedef BluetoothHealthChannelChangeCallback = {
    var onmessage: TizenCallback;
    var onclose: TizenCallback;
}

class BluetoothManager {
    public function new() {}
    extern public var BASE_UUID(default, null): String;
    extern public var deviceMajor(default, null): BluetoothClassDeviceMajor;
    extern public var deviceMinor(default, null): BluetoothClassDeviceMinor;
    extern public var deviceService(default, null): BluetoothClassDeviceService;
    extern public function getDefaultAdapter(): BluetoothAdapter;
    extern public function getLEAdapter(): BluetoothLEAdapter;
    extern public function getGATTServer(): BluetoothGATTServer;
    extern public function toByteArray(data: Bytes): UInt8Array;
    extern public function toDOMString(data: Bytes): String;
    extern public function toUint8Array(data: Bytes): UInt8Array;
    extern public function uuidTo128bit(uuid: BluetoothUUID): BluetoothUUID;
    extern public function uuidToShortestPossible(uuid: BluetoothUUID): BluetoothUUID;
    extern public function uuidsEqual(uuid1: BluetoothUUID, uuid2: BluetoothUUID): Bool;
}

class BluetoothAdapter {
    public function new() {}
    extern public var name(default, null): String;
    extern public var address(default, null): BluetoothAddress;
    extern public var powered(default, null): Bool;
    extern public var visible(default, null): Bool;
    extern public function setName(name: String, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function setChangeListener(listener: BluetoothAdapterChangeCallback): Void;
    extern public function unsetChangeListener(): Void;
    extern public function discoverDevices(successCallback: BluetoothDiscoverDevicesSuccessCallback, ?errorCallback: TizenCallback): Void;
    extern public function stopDiscovery(?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function getKnownDevices(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function getDevice(address: BluetoothAddress, successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function createBonding(address: BluetoothAddress, successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function destroyBonding(address: BluetoothAddress, successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function registerRFCOMMServiceByUUID(uuid: BluetoothUUID, name: String, successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

class BluetoothLEAdapter {
    public function new() {}
    extern public function startScan(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function stopScan(): Void;
    extern public function isScanning(): Bool;
    extern public function startAdvertise(advertiseData: BluetoothLEAdvertiseData, packetType: EitherType<String, BluetoothAdvertisePacketType>, successCallback: TizenCallback, ?errorCallback: TizenCallback, ?mode: EitherType<String, BluetoothAdvertisingMode>, ?connectable: Bool): Void;
    extern public function stopAdvertise(): Void;
    extern public function addConnectStateChangeListener(listener: BluetoothLEConnectChangeCallback): Int64;
    extern public function removeConnectStateChangeListener(watchID: Int64): Void;
}

class BluetoothGATTService {
    public function new() {}
    extern public var serviceUuid(default, null): BluetoothUUID;
    extern public var services(default, null): Array<BluetoothGATTServiceVariant>;
    extern public var characteristics(default, null): Array<BluetoothGATTCharacteristicVariant>;
}

class BluetoothGATTServerService extends BluetoothGATTService {
    extern public function new();
    extern public var isPrimary(default, null): Bool;
    extern public function unregister(?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

class BluetoothGATTCharacteristic {
    public function new() {}
    extern public var descriptors(default, null): Array<BluetoothGATTDescriptorVariant>;
    extern public var isBroadcast(default, null): Bool;
    extern public var hasExtendedProperties(default, null): Bool;
    extern public var isNotify(default, null): Bool;
    extern public var isIndication(default, null): Bool;
    extern public var isReadable(default, null): Bool;
    extern public var isSignedWrite(default, null): Bool;
    extern public var isWritable(default, null): Bool;
    extern public var isWriteNoResponse(default, null): Bool;
    extern public var uuid(default, null): BluetoothUUID;
    extern public function readValue(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function writeValue(bytes: Bytes, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function addValueChangeListener(callback: TizenCallback): Int64;
    extern public function removeValueChangeListener(watchID: Int64): Void;
}

class BluetoothGATTServerCharacteristic extends BluetoothGATTCharacteristic {
    extern public function new();
    extern public var readPermission(default, null): Bool;
    extern public var writePermission(default, null): Bool;
    extern public var encryptedReadPermission(default, null): Bool;
    extern public var encryptedWritePermission(default, null): Bool;
    extern public var encryptedSignedReadPermission(default, null): Bool;
    extern public var encryptedSignedWritePermission(default, null): Bool;
    extern public function notifyAboutValueChange(value: Bytes, clientAddress: BluetoothAddress, ?notificationCallback: NotificationCallback, ?errorCallback: TizenCallback): Void;
    extern public function setReadValueRequestCallback(readValueRequestCallback: TizenCallback, successCallback: TizenCallback, ?errorCallback: TizenCallback, ?sendResponseSuccessCallback: TizenCallback, ?sendResponseErrorCallback: TizenCallback): Void;
    extern public function setWriteValueRequestCallback(writeValueRequestCallback: TizenCallback, successCallback: TizenCallback, ?errorCallback: TizenCallback, ?sendResponseSuccessCallback: TizenCallback, ?sendResponseErrorCallback: TizenCallback): Void;
}

class BluetoothGATTDescriptor {
    public function new() {}
    extern public var uuid(default, null): BluetoothUUID;
    extern public function readValue(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function writeValue(value: Bytes, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

class BluetoothGATTServerDescriptor extends BluetoothGATTDescriptor {
    extern public function new();
    extern public var readPermission(default, null): Bool;
    extern public var writePermission(default, null): Bool;
    extern public var encryptedReadPermission(default, null): Bool;
    extern public var encryptedWritePermission(default, null): Bool;
    extern public var encryptedSignedReadPermission(default, null): Bool;
    extern public var encryptedSignedWritePermission(default, null): Bool;
    extern public function setReadValueRequestCallback(readValueRequestCallback: TizenCallback, ?successCallback: TizenCallback, ?errorCallback: TizenCallback, ?sendResponseSuccessCallback: TizenCallback, ?sendResponseErrorCallback: TizenCallback): Void;
    extern public function setWriteValueRequestCallback(writeValueRequestCallback: TizenCallback, ?successCallback: TizenCallback, ?errorCallback: TizenCallback, ?sendResponseSuccessCallback: TizenCallback, ?sendResponseErrorCallback: TizenCallback): Void;
}

class BluetoothGATTServer {
    public function new() {}
    extern public var isRunning(default, null): Bool;
    extern public var services(default, null): Array<BluetoothGATTServerService>;
    extern public function start(?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function stop(?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function registerService(service: BluetoothGATTServerServiceInit, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function unregisterAllServices(?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function getConnectionMtu(clientAddress: BluetoothAddress, callback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

typedef BluetoothLEConnectChangeCallback = {
    var onconnected: TizenCallback;
    var ondisconnected: TizenCallback;
}

@:native("tizen.GATTRequestReply")
extern class GATTRequestReply {
    extern public function new(statusCode: Int64, ?data: Bytes);
    extern public var statusCode(default, null): Int64;
    extern public var data(default, null): Bytes;
}

typedef NotificationCallback = {
    var onnotificationsuccess: TizenCallback;
    var onnotificationfail: TizenCallback;
    var onnotificationpush: TizenCallback;
}

class BluetoothDevice {
    public function new() {}
    extern public var name(default, null): String;
    extern public var address(default, null): BluetoothAddress;
    extern public var deviceClass(default, null): BluetoothClass;
    extern public var isBonded(default, null): Bool;
    extern public var isTrusted(default, null): Bool;
    extern public var isConnected(default, null): Bool;
    extern public var uuids(default, null): Array<BluetoothUUID>;
    extern public function connectToServiceByUUID(uuid: BluetoothUUID, successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

class BluetoothLEDevice {
    public function new() {}
    extern public var address(default, null): BluetoothAddress;
    extern public var name(default, null): String;
    extern public var txpowerlevel(default, null): Int64;
    extern public var appearance(default, null): Int64;
    extern public var uuids(default, null): Array<BluetoothUUID>;
    extern public var solicitationuuids(default, null): Array<BluetoothLESolicitationUUID>;
    extern public var serviceData(default, null): Array<BluetoothLEServiceData>;
    extern public var manufacturerData(default, null): Array<BluetoothLEManufacturerData>;
    extern public var rssi(default, null): Int64;
    extern public function connect(?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function disconnect(?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function isConnected(): Bool;
    extern public function getService(uuid: BluetoothUUID): BluetoothGATTService;
    extern public function getServiceAllUuids(): Array<BluetoothUUID>;
    extern public function addConnectStateChangeListener(listener: TizenCallback): Int64;
    extern public function removeConnectStateChangeListener(watchID: Int64): Void;
    extern public function getAttMtu(): Int64;
    extern public function requestAttMtuChange(newAttMtu: Int64): Void;
    extern public function addAttMtuChangeListener(callback: TizenCallback): Int64;
    extern public function removeAttMtuChangeListener(watchID: Int64): Void;
}

class BluetoothSocket {
    public function new() {}
    extern public var uuid(default, null): BluetoothUUID;
    extern public var state(default, null): EitherType<String, BluetoothSocketState>;
    extern public var peer(default, null): BluetoothDevice;
    extern public var onmessage(default, null): TizenCallback;
    extern public var onclose(default, null): TizenCallback;
    extern public function writeData(data: Bytes): Int64;
    extern public function readData(): UInt8Array;
    extern public function close(): Void;
}

class BluetoothClass {
    public function new() {}
    extern public var major(default, null): Octet;
    extern public var minor(default, null): Octet;
    extern public var services(default, null): Array<UInt>;
    extern public function hasService(service: UInt): Bool;
}

@:enum abstract BluetoothClassDeviceMajor(Octet) {
    var MISC = 0x00;
    var COMPUTER = 0x01;
    var PHONE = 0x02;
    var NETWORK = 0x03;
    var AUDIO_VIDEO = 0x04;
    var PERIPHERAL = 0x05;
    var IMAGING = 0x06;
    var WEARABLE = 0x07;
    var TOY = 0x08;
    var HEALTH = 0x09;
    var UNCATEGORIZED = 0x1F;
}

@:enum abstract BluetoothClassDeviceMinor(Octet) {
    var COMPUTER_UNCATEGORIZED = 0x00;
    var COMPUTER_DESKTOP = 0x01;
    var COMPUTER_SERVER = 0x02;
    var COMPUTER_LAPTOP = 0x03;
    var COMPUTER_HANDHELD_PC_OR_PDA = 0x04;
    var COMPUTER_PALM_PC_OR_PDA = 0x05;
    var COMPUTER_WEARABLE = 0x06;
    var PHONE_UNCATEGORIZED = 0x00;
    var PHONE_CELLULAR = 0x01;
    var PHONE_CORDLESS = 0x02;
    var PHONE_SMARTPHONE = 0x03;
    var PHONE_MODEM_OR_GATEWAY = 0x04;
    var PHONE_ISDN = 0x05;
    var AV_UNRECOGNIZED = 0x00;
    var AV_WEARABLE_HEADSET = 0x01;
    var AV_HANDSFREE = 0x02;
    var AV_MICROPHONE = 0x04;
    var AV_LOUDSPEAKER = 0x05;
    var AV_HEADPHONES = 0x06;
    var AV_PORTABLE_AUDIO = 0x07;
    var AV_CAR_AUDIO = 0x08;
    var AV_SETTOP_BOX = 0x09;
    var AV_HIFI = 0x0a;
    var AV_VCR = 0x0b;
    var AV_VIDEO_CAMERA = 0x0c;
    var AV_CAMCORDER = 0x0d;
    var AV_MONITOR = 0x0e;
    var AV_DISPLAY_AND_LOUDSPEAKER = 0x0f;
    var AV_VIDEO_CONFERENCING = 0x10;
    var AV_GAMING_TOY = 0x12;
    var PERIPHERAL_UNCATEGORIZED = 0;
    var PERIPHERAL_KEYBOARD = 0x10;
    var PERIPHERAL_POINTING_DEVICE = 0x20;
    var PERIPHERAL_KEYBOARD_AND_POINTING_DEVICE = 0x30;
    var PERIPHERAL_JOYSTICK = 0x01;
    var PERIPHERAL_GAMEPAD = 0x02;
    var PERIPHERAL_REMOTE_CONTROL = 0x03;
    var PERIPHERAL_SENSING_DEVICE = 0x04;
    var PERIPHERAL_DEGITIZER_TABLET = 0x05;
    var PERIPHERAL_CARD_READER = 0x06;
    var PERIPHERAL_DIGITAL_PEN = 0x07;
    var PERIPHERAL_HANDHELD_SCANNER = 0x08;
    var PERIPHERAL_HANDHELD_INPUT_DEVICE = 0x09;
    var IMAGING_UNCATEGORIZED = 0x00;
    var IMAGING_DISPLAY = 0x04;
    var IMAGING_CAMERA = 0x08;
    var IMAGING_SCANNER = 0x10;
    var IMAGING_PRINTER = 0x20;
    var WEARABLE_WRITST_WATCH = 0x01;
    var WEARABLE_PAGER = 0x02;
    var WEARABLE_JACKET = 0x03;
    var WEARABLE_HELMET = 0x04;
    var WEARABLE_GLASSES = 0x05;
    var TOY_ROBOT = 0x01;
    var TOY_VEHICLE = 0x02;
    var TOY_DOLL = 0x03;
    var TOY_CONTROLLER = 0x04;
    var TOY_GAME = 0x05;
    var HEALTH_UNDEFINED = 0x00;
    var HEALTH_BLOOD_PRESSURE_MONITOR = 0x01;
    var HEALTH_THERMOMETER = 0x02;
    var HEALTH_WEIGHING_SCALE = 0x03;
    var HEALTH_GLUCOSE_METER = 0x04;
    var HEALTH_PULSE_OXIMETER = 0x05;
    var HEALTH_PULSE_RATE_MONITOR = 0x06;
    var HEALTH_DATA_DISPLAY = 0x07;
    var HEALTH_STEP_COUNTER = 0x08;
    var HEALTH_BODY_COMPOSITION_ANALYZER = 0x09;
    var HEALTH_PEAK_FLOW_MONITOR = 0x0a;
    var HEALTH_MEDICATION_MONITOR = 0x0b;
    var HEALTH_KNEE_PROSTHESIS = 0x0c;
    var HEALTH_ANKLE_PROSTHESIS = 0x0d;
}

@:enum abstract BluetoothClassDeviceService(Int) {
    var LIMITED_DISCOVERABILITY = 0x0001;
    var POSITIONING = 0x0008;
    var NETWORKING = 0x0010;
    var RENDERING = 0x0020;
    var CAPTURING = 0x0040;
    var OBJECT_TRANSFER = 0x0080;
    var AUDIO = 0x0100;
    var TELEPHONY = 0x0200;
    var INFORMATION = 0x0400;
}

class BluetoothServiceHandler {
    public function new() {}
    extern public var uuid(default, null): BluetoothUUID;
    extern public var name(default, null): String;
    extern public var isConnected(default, null): Bool;
    extern public var onconnect(default, null): TizenCallback;
    extern public function unregister(?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

typedef BluetoothAdapterChangeCallback = {
    var onstatechanged: TizenCallback;
    var onnamechanged: TizenCallback;
    var onvisibilitychanged: TizenCallback;
}

typedef BluetoothDiscoverDevicesSuccessCallback = {
    var onstarted: TizenCallback;
    var ondevicefound: TizenCallback;
    var ondevicedisappeared: TizenCallback;
    var onfinished: TizenCallback;
}

typedef AddressBookId = String;
typedef ContactId = String;
typedef PersonId = String;
typedef ContactGroupId = String;
typedef ContactUsageCountFilter = EitherType<AttributeFilter, AttributeRangeFilter>;

@:enum abstract ContactTextFormat(String) {
    var VCARD_30;
}

@:enum abstract ContactRelationshipType(String) {
    var OTHER;
    var ASSISTANT;
    var BROTHER;
    var CHILD;
    var DOMESTIC_PARTNER;
    var FATHER;
    var FRIEND;
    var MANAGER;
    var MOTHER;
    var PARENT;
    var PARTNER;
    var REFERRED_BY;
    var RELATIVE;
    var SISTER;
    var SPOUSE;
    var CUSTOM;
}

@:enum abstract ContactInstantMessengerType(String) {
    var OTHER;
    var GOOGLE;
    var WLM;
    var YAHOO;
    var FACEBOOK;
    var ICQ;
    var AIM;
    var QQ;
    var JABBER;
    var SKYPE;
    var IRC;
    var CUSTOM;
}

@:enum abstract ContactUsageType(String) {
    var OUTGOING_CALL;
    var OUTGOING_MSG;
    var OUTGOING_EMAIL;
    var INCOMING_CALL;
    var INCOMING_MSG;
    var INCOMING_EMAIL;
    var MISSED_CALL;
    var REJECTED_CALL;
    var BLOCKED_CALL;
    var BLOCKED_MSG;
}

typedef ContactInit = {
    var name: ContactName;
    var addresses: Array<ContactAddress>;
    var photoURI: String;
    var phoneNumbers: Array<ContactPhoneNumber>;
    var emails: Array<ContactEmailAddress>;
    var messengers: Array<ContactInstantMessenger>;
    var relationships: Array<ContactRelationship>;
    var extensions: Array<ContactExtension>;
    var birthday: Date;
    var anniversaries: Array<ContactAnniversary>;
    var organizations: Array<ContactOrganization>;
    var notes: Array<String>;
    var urls: Array<ContactWebSite>;
    var ringtoneURI: String;
    var messageAlertURI: String;
    var vibrationURI: String;
    var groupIds: Array<ContactGroupId>;
}

typedef ContactNameInit = {
    var prefix: String;
    var suffix: String;
    var firstName: String;
    var middleName: String;
    var lastName: String;
    var nicknames: Array<String>;
    var phoneticFirstName: String;
    var phoneticMiddleName: String;
    var phoneticLastName: String;
}

typedef ContactOrganizationInit = {
    var name: String;
    var department: String;
    var title: String;
    var role: String;
    var logoURI: String;
}

typedef ContactAddressInit = {
    var country: String;
    var region: String;
    var city: String;
    var streetAddress: String;
    var additionalInformation: String;
    var postalCode: String;
    var isDefault: Bool;
    var types: Array<String>;
    var label: String;
}

typedef ContactExtensionInit = {
    var data1: Int64;
    var data2: String;
    var data3: String;
    var data4: String;
    var data5: String;
    var data6: String;
    var data7: String;
    var data8: String;
    var data9: String;
    var data10: String;
    var data11: String;
    var data12: String;
}

class ContactManager {
    public function new() {}
    extern public function getAddressBooks(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function getUnifiedAddressBook(): AddressBook;
    extern public function getDefaultAddressBook(): AddressBook;
    extern public function addAddressBook(addressBook: AddressBook): Void;
    extern public function removeAddressBook(addressBookId: AddressBookId): Void;
    extern public function getAddressBook(addressBookId: AddressBookId): AddressBook;
    extern public function get(personId: PersonId): Person;
    extern public function update(person: Person): Void;
    extern public function updateBatch(persons: Array<Person>, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function remove(personId: PersonId): Person;
    extern public function removeBatch(personIds: Array<PersonId>, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function find(successCallback: TizenCallback, ?errorCallback: TizenCallback, ?filter: AbstractFilter, ?sortMode: SortMode): Void;
    extern public function findByUsageCount(filter: ContactUsageCountFilter, successCallback: TizenCallback, ?errorCallback: TizenCallback, ?sortModeOrder: EitherType<String, SortModeOrder>, ?limit: Int64, ?offset: Int64): Void;
    extern public function addChangeListener(successCallback: PersonsChangeCallback): Int64;
    extern public function removeChangeListener(watchId: Int64): Void;
}

@:native("tizen.AddressBook")
extern class AddressBook {
    extern public function new(accountId: AccountId, name: String);
    extern public var id(default, null): AddressBookId;
    extern public var name(default, null): String;
    extern public var readOnly(default, null): Bool;
    extern public var accountId(default, null): AccountId;
    extern public function get(id: ContactId): Contact;
    extern public function add(contact: Contact): Void;
    extern public function addBatch(contacts: Array<Contact>, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function update(contact: Contact): Void;
    extern public function updateBatch(contacts: Array<Contact>, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function remove(id: ContactId): Void;
    extern public function removeBatch(ids: Array<ContactId>, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function find(successCallback: TizenCallback, ?errorCallback: TizenCallback, ?filter: AbstractFilter, ?sortMode: SortMode): Void;
    extern public function addChangeListener(successCallback: AddressBookChangeCallback, ?errorCallback: TizenCallback): Int64;
    extern public function removeChangeListener(watchId: Int64): Void;
    extern public function getGroup(groupId: ContactGroupId): ContactGroup;
    extern public function addGroup(group: ContactGroup): Void;
    extern public function updateGroup(group: ContactGroup): Void;
    extern public function removeGroup(groupId: ContactGroupId): Void;
    extern public function getGroups(): Array<ContactGroup>;
}

class Person {
    public function new() {}
    extern public var id(default, null): PersonId;
    extern public var displayName(default, null): String;
    extern public var contactCount(default, null): Int64;
    extern public var hasPhoneNumber(default, null): Bool;
    extern public var hasEmail(default, null): Bool;
    extern public var isFavorite(default, null): Bool;
    extern public var photoURI(default, null): String;
    extern public var DOMString(default, null): String;
    extern public var displayContactId(default, null): ContactId;
    extern public function link(personId: PersonId): Void;
    extern public function unlink(personId: PersonId): Person;
    extern public function getUsageCount(?type: EitherType<String, ContactUsageType>): Int64;
    extern public function resetUsageCount(?type: EitherType<String, ContactUsageType>): Void;
}

@:native("tizen.Contact")
class Contact {
    extern public function new(?contactInitDict_or_stringRepresentation: EitherType<ContactInit, String>);
    extern public var id(default, null): ContactId;
    extern public var personId(default, null): PersonId;
    extern public var addressBookId(default, null): AddressBookId;
    extern public var lastUpdated(default, null): Date;
    extern public var name(default, null): ContactName;
    extern public var addresses(default, null): Array<ContactAddress>;
    extern public var photoURI(default, null): String;
    extern public var phoneNumbers(default, null): Array<ContactPhoneNumber>;
    extern public var emails(default, null): Array<ContactEmailAddress>;
    extern public var messengers(default, null): Array<ContactInstantMessenger>;
    extern public var relationships(default, null): Array<ContactRelationship>;
    extern public var extensions(default, null): Array<ContactExtension>;
    extern public var birthday(default, null): Date;
    extern public var anniversaries(default, null): Array<ContactAnniversary>;
    extern public var organizations(default, null): Array<ContactOrganization>;
    extern public var notes(default, null): String;
    extern public var urls(default, null): Array<ContactWebSite>;
    extern public var ringtoneURI(default, null): String;
    extern public var messageAlertURI(default, null): String;
    extern public var vibrationURI(default, null): String;
    extern public var groupIds(default, null): Array<ContactGroupId>;
    extern public function convertToString(?format: ContactTextFormat): String;
    extern public function clone(): Contact;
}

@:native("tizen.ContactRef")
extern class ContactRef {
    extern public function new(addressBookId: AddressBookId, contactId: ContactId);
    extern public var addressBookId(default, null): AddressBookId;
    extern public var contactId(default, null): ContactId;
}

@:native("tizen.ContactName")
extern class ContactName {
    extern public function new(?nameInitDict: ContactNameInit);
    extern public var prefix(default, null): String;
    extern public var suffix(default, null): String;
    extern public var firstName(default, null): String;
    extern public var middleName(default, null): String;
    extern public var lastName(default, null): String;
    extern public var nicknames(default, null): Array<String>;
    extern public var phoneticFirstName(default, null): String;
    extern public var phoneticMiddleName(default, null): String;
    extern public var phoneticLastName(default, null): String;
    extern public var displayName(default, null): String;
}

@:native("tizen.ContactOrganization")
extern class ContactOrganization {
    extern public function new(?orgInitDict: ContactOrganizationInit);
    extern public var name(default, null): String;
    extern public var department(default, null): String;
    extern public var title(default, null): String;
    extern public var role(default, null): String;
    extern public var logoURI(default, null): String;
}

@:native("tizen.ContactWebSite")
extern class ContactWebSite {
    extern public function new(url: String, ?type: String);
    extern public var url(default, null): String;
    extern public var type(default, null): String;
}

@:native("tizen.ContactAnniversary")
extern class ContactAnniversary {
    extern public function new(date: Date, ?label: String);
    extern public var date(default, null): Date;
    extern public var label(default, null): String;
}

@:native("tizen.ContactAddress")
extern class ContactAddress {
    extern public function new(?addressInitDict: ContactAddressInit);
    extern public var country(default, null): String;
    extern public var region(default, null): String;
    extern public var city(default, null): String;
    extern public var streetAddress(default, null): String;
    extern public var additionalInformation(default, null): String;
    extern public var postalCode(default, null): String;
    extern public var isDefault(default, null): Bool;
    extern public var types(default, null): Array<String>;
    extern public var label(default, null): String;
}

@:native("tizen.ContactPhoneNumber")
extern class ContactPhoneNumber {
    extern public function new(number: String, ?types: Array<String>, ?isDefault: Bool);
    extern public var number(default, null): String;
    extern public var isDefault(default, null): Bool;
    extern public var types(default, null): Array<String>;
    extern public var label(default, null): String;
}

@:native("tizen.ContactEmailAddress")
extern class ContactEmailAddress {
    extern public function new(email: String, ?types: Array<String>, ?isDefault: Bool);
    extern public var email(default, null): String;
    extern public var isDefault(default, null): Bool;
    extern public var types(default, null): Array<String>;
    extern public var label(default, null): String;
}

@:native("tizen.ContactInstantMessenger")
extern class ContactInstantMessenger {
    extern public function new(imAddress: String, ?type: EitherType<String, ContactInstantMessengerType>);
    extern public var imAddress(default, null): String;
    extern public var type(default, null): EitherType<String, ContactInstantMessengerType>;
    extern public var label(default, null): String;
}

@:native("tizen.ContactGroup")
extern class ContactGroup {
    extern public function new(name: String, ?ringtoneURI: String, ?photoURI: String);
    extern public var id(default, null): ContactGroupId;
    extern public var addressBookId(default, null): AddressBookId;
    extern public var name(default, null): String;
    extern public var ringtoneURI(default, null): String;
    extern public var photoURI(default, null): String;
    extern public var readOnly(default, null): String;
}

@:native("tizen.ContactRelationship")
extern class ContactRelationship {
    extern public function new(relativeName: String, ?type: EitherType<String, ContactRelationshipType>);
    extern public var relativeName(default, null): String;
    extern public var type(default, null): EitherType<String, ContactRelationshipType>;
    extern public var label(default, null): String;
}

@:native("tizen.ContactExtension")
extern class ContactExtension {
    extern public function new(?extensionInitDict: ContactExtensionInit);
    extern public var data1(default, null): Int64;
    extern public var data2(default, null): String;
    extern public var data3(default, null): String;
    extern public var data4(default, null): String;
    extern public var data5(default, null): String;
    extern public var data6(default, null): String;
    extern public var data7(default, null): String;
    extern public var data8(default, null): String;
    extern public var data9(default, null): String;
    extern public var data10(default, null): String;
    extern public var data11(default, null): String;
    extern public var data12(default, null): String;
}

typedef AddressBookChangeCallback = {
    var oncontactsadded: TizenCallback;
    var oncontactsupdated: TizenCallback;
    var oncontactsremoved: TizenCallback;
}

typedef PersonsChangeCallback = {
    var onpersonsadded: TizenCallback;
    var onpersonsupdated: TizenCallback;
    var onpersonsremoved: TizenCallback;
}

@:enum abstract MediaControllerServerState(String) {
    var ACTIVE;
    var INACTIVE;
}

@:enum abstract MediaControllerSearchCategory(String) {
    var NO_CATEGORY;
    var TITLE;
    var ARTIST;
    var ALBUM;
    var GENRE;
    var TPO;
}

@:enum abstract MediaControllerPlaybackState(String) {
    var PLAY;
    var PAUSE;
    var STOP;
    var NEXT;
    var PREV;
    var FORWARD;
    var REWIND;
}

@:enum abstract MediaControllerPlaybackAction(String) {
    var PLAY;
    var PAUSE;
    var STOP;
    var NEXT;
    var PREV;
    var FORWARD;
    var REWIND;
    var TOGGLE_PLAY_PAUSE;
}

@:enum abstract MediaControllerRepeatState(String) {
    var REPEAT_OFF;
    var REPEAT_ONE;
    var REPEAT_ALL;
}

@:enum abstract MediaControllerContentType(String) {
    var IMAGE;
    var MUSIC;
    var VIDEO;
    var OTHER;
    var UNDECIDED;
}

@:enum abstract MediaControllerContentAgeRating(String) {
    var ALL;
    var ONE         = "1";
    var TWO         = "2";
    var THREE       = "3";
    var FOUR        = "4";
    var FIVE        = "5";
    var SIX         = "6";
    var SEVEN       = "7";
    var EIGHT       = "8";
    var NINE        = "9";
    var TEN         = "10";
    var ELEVEN      = "11";
    var TWELVE      = "12";
    var THIRTEEN    = "13";
    var FOURTEEN    = "14";
    var FIFTEEN     = "15";
    var SIXTEEN     = "16";
    var SEVENTEEN   = "17";
    var EIGHTEEN    = "18";
    var NINETEEN    = "19";
}

@:enum abstract MediaControllerAbilitySupport(String) {
    var YES;
    var NO;
    var UNDECIDED;
}

@:enum abstract MediaControllerSimpleAbility(String) {
    var PLAYBACK_POSITION;
    var SHUFFLE;
    var REPEAT;
    var PLAYLIST;
    var CLIENT_CUSTOM;
    var SEARCH;
    var SUBTITLES;
    var MODE_360;
}

@:enum abstract MediaControllerDisplayModeType(String) {
    var LETTER_BOX;
    var ORIGIN_SIZE;
    var FULL_SCREEN;
    var CROPPED_FULL;
}

@:enum abstract MediaControllerDisplayRotationType(String) {
    var ROTATION_NONE;
    var ROTATION_90;
    var ROTATION_180;
    var ROTATION_270;
}

typedef MediaControllerMetadataInit = {
    var title: String;
    var artist: String;
    var album: String;
    var author: String;
    var genre: String;
    var duration: String;
    var date: String;
    var copyright: String;
    var description: String;
    var trackNum: String;
    var picture: String;
    var seasonNumber: Int64;
    var seasonTitle: String;
    var episodeNumber: Int64;
    var episodeTitle: String;
    var resolutionWidth: Int64;
    var resolutionHeight: Int64;
}

class MediaControllerManager {
    public function new() {}
    extern public function getClient(): MediaControllerClient;
    extern public function createServer(): MediaControllerServer;
}

class MediaControllerServer {
    public function new() {}
    extern public var playbackInfo(default, null): MediaControllerPlaybackInfo;
    extern public var playback(default, null): MediaControllerServerPlaybackInfo;
    extern public var playlists(default, null): MediaControllerPlaylists;
    extern public var iconURI(default, null): String;
    extern public var abilities(default, null): MediaControllerAbilities;
    extern public var subtitles(default, null): MediaControllerSubtitles;
    extern public var mode360(default, null): MediaControllerMode360;
    extern public var displayMode(default, null): MediaControllerDisplayMode;
    extern public var displayRotation(default, null): MediaControllerDisplayRotation;
    extern public function getAllClientsInfo(): Array<MediaControllerClientInfo>;
    extern public function updatePlaybackState(state: EitherType<String, MediaControllerPlaybackState>): Void;
    extern public function updateIconURI(iconURI: String): Void;
    extern public function updatePlaybackPosition(position: Int64): Void;
    extern public function updatePlaybackAgeRating(rating: EitherType<String, MediaControllerContentAgeRating>): Void;
    extern public function updatePlaybackContentType(type: EitherType<String, MediaControllerContentType>): Void;
    extern public function updateShuffleMode(mode: Bool): Void;
    extern public function updateRepeatMode(mode: Bool): Void;
    extern public function updateRepeatState(state: EitherType<String, MediaControllerRepeatState>): Void;
    extern public function updateMetadata(metadata: MediaControllerMetadata): Void;
    extern public function addChangeRequestPlaybackInfoListener(listener: TizenCallback): Int64;
    extern public function removeChangeRequestPlaybackInfoListener(watchId: Int64): Void;
    extern public function setSearchRequestListener(listener: TizenCallback): Void;
    extern public function unsetSearchRequestListener(): Void;
    extern public function addCommandListener(listener: TizenCallback): Int64;
    extern public function removeCommandListener(watchId: Int64): Void;
    extern public function createPlaylist(name: String): MediaControllerPlaylist;
    extern public function savePlaylist(playlist: MediaControllerPlaylist, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function deletePlaylist(playlistName: String, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function updatePlaybackItem(playlistName: String, index: String): Void;
    extern public function getAllPlaylists(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

typedef MediaControllerPlaybackInfo = {
    var state: MediaControllerPlaybackState;
    var position: Int64;
    var ageRating: EitherType<String, MediaControllerContentAgeRating>;
    var contentType: EitherType<String, MediaControllerContentType>;
    var shuffleMode: Bool;
    var repeatMode: Bool;
    var repeatState: EitherType<String, MediaControllerRepeatState>;
    var metadata: EitherType<String, MediaControllerMetadata>;
    var index: String;
    var playlistName: String;
}

class MediaControllerClient {
    public function new() {}
    extern public function findServers(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function getLatestServerInfo(): MediaControllerServerInfo;
    extern public function addAbilityChangeListener(listener: MediaControllerAbilityChangeCallback): Int64;
    extern public function removeAbilityChangeListener(watchId: Int64): Void;
    extern public function findSubscribedServers(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function setCustomEventListener(listener: TizenCallback): Void;
    extern public function unsetCustomEventListener(): Void;
}

class MediaControllerServerInfo {
    public function new() {}
    extern public var name(default, null): ApplicationId;
    extern public var state(default, null): EitherType<String, MediaControllerServerState>;
    extern public var playbackInfo(default, null): MediaControllerPlaybackInfo;
    extern public var playback(default, null): MediaControllerServerInfoPlaybackInfo;
    extern public var playlists(default, null): MediaControllerPlaylistsInfo;
    extern public var iconURI(default, null): String;
    extern public var abilities(default, null): MediaControllerAbilitiesInfo;
    extern public var subtitles(default, null): MediaControllerAbilitiesInfo;
    extern public var mode360(default, null): MediaControllerMode360Info;
    extern public var displayMode(default, null): MediaControllerDisplayModeInfo;
    extern public var displayRotation(default, null): MediaControllerDisplayRotationInfo;
    extern public function sendPlaybackState(state: EitherType<String, MediaControllerPlaybackState>, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function sendPlaybackPosition(position: Int64, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function sendShuffleMode(mode: Bool, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function sendRepeatMode(mode: Bool, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function sendRepeatState(state: EitherType<String, MediaControllerRepeatState>, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function sendSearchRequest(request: Array<SearchFilter>, replyCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function sendCommand(command: String, data: Bundle, successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function addServerStatusChangeListener(listener: TizenCallback): Int64;
    extern public function removeServerStatusChangeListener(watchId: Int64): Void;
    extern public function addPlaybackInfoChangeListener(listener: MediaControllerPlaybackInfoChangeCallback): Int64;
    extern public function removePlaybackInfoChangeListener(watchId: Int64): Void;
    extern public function getAllPlaylists(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function sendPlaybackItem(playlistName: String, index: String, state: EitherType<String, MediaControllerPlaybackState>, position: Int64): Void;
    extern public function addPlaylistUpdatedListener(listener: MediaControllerPlaylistUpdatedCallback): Int64;
    extern public function removePlaylistUpdatedListener(listenerId: Int64): Void;
}

class MediaControllerServerPlaybackInfo {
    public function new() {}
    extern public var state(default, null): EitherType<String, MediaControllerPlaybackState>;
    extern public var position(default, null): Int64;
    extern public var ageRating(default, null): EitherType<String, MediaControllerContentAgeRating>;
    extern public var contentType(default, null): EitherType<String, MediaControllerContentType>;
    extern public var shuffleMode(default, null): Bool;
    extern public var repeatState(default, null): MediaControllerMetadata;
    extern public var index(default, null): String;
    extern public var playlistName(default, null): String;
    extern public function updatePlaybackItem(playlistName: String, index: String): Void;
    extern public function addChangeRequestListener(listener: MediaControllerChangeRequestPlaybackInfoCallback): Int64;
    extern public function removeChangeRequestListener(watchId: Int64): Void;
}

class MediaControllerServerInfoPlaybackInfo {
    public function new() {}
    extern public var state(default, null): EitherType<String, MediaControllerPlaybackState>;
    extern public var position(default, null): Int64;
    extern public var ageRating(default, null): EitherType<String, MediaControllerContentAgeRating>;
    extern public var contentType(default, null): EitherType<String, MediaControllerContentType>;
    extern public var shuffleMode(default, null): Bool;
    extern public var repeatState(default, null): MediaControllerMetadata;
    extern public var metadata(default, null): MediaControllerMetadata;
    extern public var index(default, null): String;
    extern public var playlistName(default, null): String;
    extern public function sendPlaybackAction(action: EitherType<String, MediaControllerPlaybackAction>, ?replyCallback: TizenCallback): Void;
    extern public function sendPlaybackPosition(position: Int64, ?replyCallback: TizenCallback): Void;
    extern public function sendShuffleMode(mode: Bool, ?replyCallback: TizenCallback): Void;
    extern public function sendRepeatState(state: EitherType<String, MediaControllerRepeatState>, ?replyCallback: TizenCallback): Void;
    extern public function addPlaybackInfoChangeListener(listener: MediaControllerPlaybackInfoChangeCallback): Int64;
    extern public function removePlaybackInfoChangeListener(watchId: Int64): Void;
}

class MediaControllerPlaylists {
    public function new() {}
    extern public function createPlaylist(name: String): MediaControllerPlaylist;
    extern public function savePlaylist(playlist: MediaControllerPlaylist, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function deletePlaylist(playlistName: String, ?successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function getAllPlaylists(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function getPlaylist(playlistName: String): MediaControllerPlaylist;
}

class MediaControllerPlaylistsInfo {
    public function new() {}
    extern public function getAllPlaylists(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
    extern public function sendPlaybackItem(playlistName: String, index: String, action: EitherType<String, MediaControllerPlaybackAction>, position: Int64, replyCallback: TizenCallback): Void;
    extern public function addPlaylistUpdatedListener(listener: MediaControllerPlaylistUpdatedCallback): Int64;
    extern public function removePlaylistUpdatedListener(listenerId: Int64): Void;
    extern public function getPlaylist(playlistName: String): MediaControllerPlaylist;
}

typedef MediaControllerAbilities = {
    var playback: MediaControllerPlaybackAbilities;
    var displayMode: MediaControllerDisplayModeAbilities;
    var displayRotation: MediaControllerDisplayRotationAbilities;
    var playbackPosition: EitherType<String, MediaControllerAbilitySupport>;
    var shuffle: EitherType<String, MediaControllerAbilitySupport>;
    var repeat: EitherType<String, MediaControllerAbilitySupport>;
    var playlist: EitherType<String, MediaControllerAbilitySupport>;
    var clientCustom: EitherType<String, MediaControllerAbilitySupport>;
    var search: EitherType<String, MediaControllerAbilitySupport>;
    var subtitles: EitherType<String, MediaControllerAbilitySupport>;
    var mode360: EitherType<String, MediaControllerAbilitySupport>;
}

class MediaControllerPlaybackAbilities {
    public function new() {}
    extern public var play(default, null): EitherType<String, MediaControllerAbilitySupport>;
    extern public var pause(default, null): EitherType<String, MediaControllerAbilitySupport>;
    extern public var stop(default, null): EitherType<String, MediaControllerAbilitySupport>;
    extern public var next(default, null): EitherType<String, MediaControllerAbilitySupport>;
    extern public var prev(default, null): EitherType<String, MediaControllerAbilitySupport>;
    extern public var forward(default, null): EitherType<String, MediaControllerAbilitySupport>;
    extern public var rewind(default, null): EitherType<String, MediaControllerAbilitySupport>;
    extern public var togglePlayPause(default, null): EitherType<String, MediaControllerAbilitySupport>;
    extern public function saveAbilities(): Void;
}

typedef MediaControllerDisplayModeAbilities = {
    var letterBox: EitherType<String, MediaControllerAbilitySupport>;
    var originSize: EitherType<String, MediaControllerAbilitySupport>;
    var fullScreen: EitherType<String, MediaControllerAbilitySupport>;
    var croppedFull: EitherType<String, MediaControllerAbilitySupport>;
}

typedef MediaControllerDisplayRotationAbilities = {
    var rotationNone: EitherType<String, MediaControllerAbilitySupport>;
    var rotation90: EitherType<String, MediaControllerAbilitySupport>;
    var rotation180: EitherType<String, MediaControllerAbilitySupport>;
    var rotation270: EitherType<String, MediaControllerAbilitySupport>;
}

class MediaControllerAbilitiesInfo {
    public function new() {}
    extern public var playback(default, null): MediaControllerPlaybackAbilitiesInfo;
    extern public var displayMode(default, null): MediaControllerDisplayModeAbilitiesInfo;
    extern public var displayRotation(default, null): MediaControllerDisplayRotationAbilitiesInfo;
    extern public var playbackPosition(default, null): EitherType<String, MediaControllerAbilitySupport>;
    extern public var shuffle(default, null): EitherType<String, MediaControllerAbilitySupport>;
    extern public var repeat(default, null): EitherType<String, MediaControllerAbilitySupport>;
    extern public var playlist(default, null): EitherType<String, MediaControllerAbilitySupport>;
    extern public var clientCustom(default, null): EitherType<String, MediaControllerAbilitySupport>;
    extern public var search(default, null): EitherType<String, MediaControllerAbilitySupport>;
    extern public var subtitles(default, null): EitherType<String, MediaControllerAbilitySupport>;
    extern public var mode360(default, null): EitherType<String, MediaControllerAbilitySupport>;
    extern public function subscribe(): Void;
    extern public function unsubscribe(): Void;
}

typedef MediaControllerPlaybackAbilitiesInfo = {
    var play: EitherType<String, MediaControllerAbilitySupport>;
    var pause: EitherType<String, MediaControllerAbilitySupport>;
    var stop: EitherType<String, MediaControllerAbilitySupport>;
    var next: EitherType<String, MediaControllerAbilitySupport>;
    var prev: EitherType<String, MediaControllerAbilitySupport>;
    var forward: EitherType<String, MediaControllerAbilitySupport>;
    var rewind: EitherType<String, MediaControllerAbilitySupport>;
    var togglePlayPause: EitherType<String, MediaControllerAbilitySupport>;
}

typedef MediaControllerDisplayModeAbilitiesInfo = {
    var letterBox: EitherType<String, MediaControllerAbilitySupport>;
    var originSize: EitherType<String, MediaControllerAbilitySupport>;
    var fullscreen: EitherType<String, MediaControllerAbilitySupport>;
    var croppedFull: EitherType<String, MediaControllerAbilitySupport>;
}

typedef MediaControllerDisplayRotationAbilitiesInfo = {
    var rotationNone: EitherType<String, MediaControllerAbilitySupport>;
    var rotation90: EitherType<String, MediaControllerAbilitySupport>;
    var rotation180: EitherType<String, MediaControllerAbilitySupport>;
    var rotation270: EitherType<String, MediaControllerAbilitySupport>;
}

class MediaControllerSubtitles {
    public function new() {}
    extern public var enabled(default, null): Bool;
    extern public function addChangeRequestListener(listener: TizenCallback): Int64;
    extern public function removeChangeRequestListener(watchId: Int64): Void;
}

class MediaControllerSubtitlesInfo {
    public function new() {}
    extern public var enabled(default, null): Bool;
    extern public function sendRequest(enabled: Bool, replyCallback: TizenCallback): Void;
    extern public function addModeChangeListener(listener: TizenCallback): Int64;
    extern public function removeModeChangeListener(watchId: Int64): Void;
}

class MediaControllerMode360 {
    public function new() {}
    extern public var enabled(default, null): Bool;
    extern public function addChangeRequestListener(listener: TizenCallback): Int64;
    extern public function removeChangeRequestListener(watchId: Int64): Void;
}

class MediaControllerMode360Info {
    public function new() {}
    extern public var enabled(default, null): Bool;
    extern public function sendRequest(enabled: Bool, replyCallback: TizenCallback): Void;
    extern public function addModeChangeListener(listener: TizenCallback): Int64;
    extern public function removeModeChangeListener(watchId: Int64): Void;
}

class MediaControllerDisplayMode {
    public function new() {}
    extern public var type(default, null): EitherType<String, MediaControllerDisplayModeType>;
    extern public function addChangeRequestListener(listener: TizenCallback): Int64;
    extern public function removeChangeRequestListener(watchId: Int64): Void;
}

class MediaControllerDisplayModeInfo {
    public function new() {}
    extern public var type(default, null): EitherType<String, MediaControllerDisplayModeType>;
    extern public function sendRequest(type: EitherType<String, MediaControllerDisplayModeType>, replyCallback: TizenCallback): Void;
    extern public function addModeChangeListener(listener: TizenCallback): Int64;
    extern public function removeModeChangeListener(watchId: Int64): Void;
}

class MediaControllerDisplayRotation {
    public function new() {}
    extern public var displayRotation(default, null): EitherType<String, MediaControllerDisplayRotationType>;
    extern public function addChangeRequestListener(listener: TizenCallback): Int64;
    extern public function removeChangeRequestListener(watchId: Int64): Void;
}

class MediaControllerClientInfo {
    public function new() {}
    extern public var name(default, null): ApplicationId;
    extern public function sendEvent(eventName: String, data: Bundle, replyCallback: TizenCallback): Void;
}

class MediaControllerDisplayRotationInfo {
    public function new() {}
    extern public var displayRotation(default, null): EitherType<String, MediaControllerDisplayRotationType>;
    extern public function sendRequest(displayRotation: EitherType<String, MediaControllerDisplayRotationType>, replyCallback: TizenCallback): Void;
    extern public function addDisplayRotationChangeListener(listener: TizenCallback): Int64;
    extern public function removeDisplayRotationChangeListener(watchId: Int64): Void;
}

class MediaControllerMetadata {
    public function new() {}
    extern public var title(default, null): String;
    extern public var artist(default, null): String;
    extern public var album(default, null): String;
    extern public var author(default, null): String;
    extern public var genre(default, null): String;
    extern public var duration(default, null): String;
    extern public var date(default, null): String;
    extern public var copyright(default, null): String;
    extern public var description(default, null): String;
    extern public var trackNum(default, null): String;
    extern public var picture(default, null): String;
    extern public var seasonNumber(default, null): Int64;
    extern public var seasonTitle(default, null): String;
    extern public var episodeNumber(default, null): Int64;
    extern public var episodeTitle(default, null): String;
    extern public var resolutionWidth(default, null): Int64;
    extern public var resolutionHeight(default, null): Int64;
    extern public function save(): Void;
}

typedef MediaControllerPlaylistItem = {
    var index: String;
    var metadata: MediaControllerMetadata;
}

class MediaControllerPlaylist {
    public function new() {}
    extern public var name(default, null): String;
    extern public function addItem(index: String, metadata: MediaControllerMetadataInit): Void;
    extern public function getItems(successCallback: TizenCallback, ?errorCallback: TizenCallback): Void;
}

@:native("tizen.SearchFilter")
extern class SearchFilter {
    extern public function new(contentType: EitherType<String, MediaControllerContentType>, ?category: EitherType<String, MediaControllerSearchCategory> = "NO_CATEGORY", ?keyword: String = null, ?extraData: Bundle = null);
    extern public var contentType(default, null): EitherType<String, MediaControllerContentType>;
    extern public var category(default, null): EitherType<String, MediaControllerSearchCategory>;
    extern public var keyword(default, null): String;
    extern public var extraData(default, null): Bundle;
}

@:native("tizen.RequestReply")
extern class RequestReply {
    extern public function new(data: Bundle, ?code: Int64);
    extern public var data(default, null): Bundle;
    extern public var code(default, null): Int64;
}

typedef MediaControllerPlaybackInfoChangeCallback = {
    var onplaybackchanged: TizenCallback;
    var onshufflemodechanged: TizenCallback;
    var onrepeatmodechanged: TizenCallback;
    var onrepeatstatechanged: TizenCallback;
    var onmetadatachanged: TizenCallback;
}

typedef MediaControllerChangeRequestPlaybackInfoCallback = {
    var onplaybackstaterequest: TizenCallback;
    var onplaybackactionrequest: TizenCallback;
    var onplaybackpositionrequest: TizenCallback;
    var onshufflemoderequest: TizenCallback;
    var onrepeatstaterequest: TizenCallback;
    var onplaybackitemrequest: TizenCallback;
    var onrepeatmoderequest: TizenCallback;
}

typedef MediaControllerPlaylistUpdatedCallback = {
    var onplaylistupdated: TizenCallback;
    var onplaylistdeleted: TizenCallback;
}

typedef MediaControllerAbilityChangeCallback = {
    var onplaybackabilitychanged: TizenCallback;
    var ondisplaymodeabilitychanged: TizenCallback;
    var ondisplayrotationabilitychanged: TizenCallback;
    var onsimpleabilitychanged: TizenCallback;
}

@:native("tizen")
class Tizen {
    public static var archive(default, null): ArchiveManager;
    public static var filesystem(default, null): FileSystemManager;
    public static var account(default, null): AccountManager;
    public static var alarm(default, null): AlarmManager;
    public static var application(default, null): ApplicationManager;
    public static var badge(default, null): BadgeManager;
    public static var datacontrol(default, null): DataControlManager;
    public static var inputdevice(default, null): InputDeviceManager;
    public static var messageport(default, null): MessagePortManager;
    public static var notification(default, null): NotificationManager;
    public static var packages(default, null): PackageManager;
    public static var preference(default, null): PreferenceManager;
    public static var widgetservice(default, null): WidgetServiceManager;
    public static var content(default, null): ContentManager;
    public static var download(default, null): DownloadManager;
    public static var playerutil(default, null): PlayerUtilManager;
    public static var metadata(default, null): MetadataManager;
    public static var networkbearerselection(default, null): NetworkBearerSelection;
    public static var websetting(default, null): WebSettingManager;
    public static var power(default, null): PowerManager;
    public static var feedback(default, null): FeedbackManager;
    public static var push(default, null): PushManager;
    public static var systemsetting(default, null): SystemSettingManager;
    public static var keymanager(default, null): KeyManager;
    public static var ppm(default, null): PrivacyPrivilegeManager;
    public static var sound(default, null): SoundManager;
    public static var fmradio(default, null): FMRadioManager;
    public static var exif(default, null): ExifManager;
    public static var voicecontrol(default, null): VoiceControlClientManager;
    public static var callhistory(default, null): CallHistory;
    public static var seService(default, null): SEService;
    public static var datasync(default, null): DataSynchronizationManager;
    public static var time(default, null): TimeUtil;
    public static var teec(default, null): LibTeecManager;
    public static var messaging(default, null): Messaging;
    public static var systeminfo(default, null): SystemInfo;
    public static var sensorservice(default, null): SensorService;
    public static var iotcon(default, null): Iotcon;
    public static var nfc(default, null): NFCManager;
    public static var humanactivitymonitor(default, null): HumanActivityMonitorManager;
    public static var calendar(default, null): CalendarManager;
    public static var bluetooth(default, null): BluetoothManager;
    public static var contact(default, null): ContactManager;
    public static var mediacontroller(default, null): MediaControllerManager;
    public static var tvaudiocontrol(default, null): AudioControlManager;
    public static var tvdisplaycontrol(default, null): DisplayControlManager;
    public static var tvinfo(default, null): TVInfoManager;
    public static var tvinputdevice(default, null): TVInputDeviceManager;
    public static var tvwindow(default, null): TVWindowManager;
}
