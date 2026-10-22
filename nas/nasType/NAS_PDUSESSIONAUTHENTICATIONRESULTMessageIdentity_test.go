// Copyright 2019 free5GC.org
//
// SPDX-License-Identifier: Apache-2.0
//

package nasType_test

import (
	"reflect"
	"testing"

	"github.com/Shiva-Marshall/Tossi-libs/nas"
	"github.com/Shiva-Marshall/Tossi-libs/nas/nasType"
)

func TestNasTypeNewPDUSESSIONAUTHENTICATIONRESULTMessageIdentity(t *testing.T) {
	a := nasType.NewPDUSESSIONAUTHENTICATIONRESULTMessageIdentity()
	if a == nil {
		t.Fatal("Expected value not to be nil")
	}
}

type nasTypePDUSESSIONAUTHENTICATIONRESULTMessageIdentityMessageType struct {
	in  uint8
	out uint8
}

var nasTypePDUSESSIONAUTHENTICATIONRESULTMessageIdentityMessageTypeTable = []nasTypePDUSESSIONAUTHENTICATIONRESULTMessageIdentityMessageType{
	{nas.MsgTypePDUSessionAuthenticationResult, nas.MsgTypePDUSessionAuthenticationResult},
}

func TestNasTypeGetSetPDUSESSIONAUTHENTICATIONRESULTMessageIdentityMessageType(t *testing.T) {
	a := nasType.NewPDUSESSIONAUTHENTICATIONRESULTMessageIdentity()
	for _, table := range nasTypePDUSESSIONAUTHENTICATIONRESULTMessageIdentityMessageTypeTable {
		a.SetMessageType(table.in)
		if !reflect.DeepEqual(table.out, a.GetMessageType()) {
			t.Errorf("Not equal: expected %v, got %v", table.out, a.GetMessageType())
		}
	}
}
